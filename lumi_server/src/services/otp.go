package services

import (
	"crypto/hmac"
	"crypto/sha256"
	"encoding/base64"
	"encoding/json"
	"errors"
	"fmt"
	"time"

	"github.com/Mahaveer86619/Lumi/src/config"
)

// The duration for which the OTP is valid.
const otpValidityDuration = 5 * time.Minute

// Custom errors for better error handling.
var (
	ErrSecretNotSet     = errors.New("secret is not set")
	ErrOTPExpired       = errors.New("OTP has expired")
	ErrInvalidSignature = errors.New("invalid OTP signature")
	ErrEmailMismatch    = errors.New("email in OTP does not match provided email")
	ErrInvalidFormat    = errors.New("invalid OTP format")
)

// otpPayload is the data structure that will be signed and encoded in the OTP.
// It is kept simple for clarity.
type otpPayload struct {
	Email     string `json:"email"`
	ExpiresAt int64  `json:"expires_at"` // Unix timestamp for expiration
}

// GenerateOTP creates a time-based, HMAC-signed OTP containing the user's email.
// The secret must be a cryptographically secure key, unique to your server.
func GenerateOTP(userEmail string) (string, error) {
	secret := []byte(config.FP_SECRET)
	if len(secret) == 0 {
		return "", ErrSecretNotSet
	}

	// 1. Create the payload with the email and a future expiration timestamp.
	payload := otpPayload{
		Email:     userEmail,
		ExpiresAt: time.Now().Add(otpValidityDuration).Unix(),
	}

	// 2. Serialize the payload to a JSON string.
	payloadBytes, err := json.Marshal(payload)
	if err != nil {
		return "", fmt.Errorf("failed to marshal payload: %w", err)
	}

	// 3. Create an HMAC-SHA256 hasher with the server's secret.
	mac := hmac.New(sha256.New, secret)
	mac.Write(payloadBytes)
	signature := mac.Sum(nil)

	// 4. Combine the payload and signature.
	combined := append(payloadBytes, signature...)

	// 5. Encode the combined data using URL-safe base64.
	otp := base64.URLEncoding.EncodeToString(combined)

	return otp, nil
}

// VerifyOTP takes an OTP string and validates it against the server's secret and the user's email.
func VerifyOTP(userEmail, otp string) error {
	secret := []byte(config.FP_SECRET)
	if len(secret) == 0 {
		return ErrSecretNotSet
	}

	// 1. Decode the URL-safe base64 string.
	combined, err := base64.URLEncoding.DecodeString(otp)
	if err != nil {
		return ErrInvalidFormat
	}

	// 2. Split the combined data into the original payload and the signature.
	// The signature length is fixed (SHA256 produces 32 bytes).
	signatureLength := sha256.Size
	if len(combined) < signatureLength {
		return ErrInvalidFormat
	}
	payloadBytes := combined[:len(combined)-signatureLength]
	receivedSignature := combined[len(combined)-signatureLength:]

	// 3. Re-compute the HMAC-SHA256 signature on the payload using the secret.
	mac := hmac.New(sha256.New, secret)
	mac.Write(payloadBytes)
	expectedSignature := mac.Sum(nil)

	// 4. Verify the signatures using hmac.Equal for constant-time comparison.
	// This prevents timing attacks.
	if !hmac.Equal(receivedSignature, expectedSignature) {
		return ErrInvalidSignature
	}

	// 5. Unmarshal the payload from JSON.
	var payload otpPayload
	if err := json.Unmarshal(payloadBytes, &payload); err != nil {
		return ErrInvalidFormat
	}

	// 6. Check if the OTP has expired.
	if time.Now().Unix() > payload.ExpiresAt {
		return ErrOTPExpired
	}

	// 7. Check if the email in the payload matches the user's email.
	if payload.Email != userEmail {
		return ErrEmailMismatch
	}

	// If all checks pass, the OTP is valid.
	return nil
}
