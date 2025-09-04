package types

// RegisterRequest represents the request body for user registration.	
type RegisterRequest struct {
	FullName string `json:"full_name"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

// LoginRequest represents the request body for user login.	
type LoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type EmailVerificationRequest struct {
	Email  string `json:"email"`
}

type VerifyEmailOTPRequest struct {
	Email string `json:"email"`
	OTP   string `json:"otp"`
}