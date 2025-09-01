package utils

import (
	"fmt"
	"math/rand"

	"github.com/google/uuid"
)

func GenerateUUID() string {
	return uuid.New().String()
}

// 6 digit random number
func GenerateOTP() (string, error) {
	otp := fmt.Sprintf("%06d", rand.Intn(1000000))
	return otp, nil
}

// HTML body with copiable otp
func GenerateHTMLBody(otp string) string {
	return fmt.Sprintf("<html><body><p>Your OTP is: <strong>%s</strong></p></body></html>", otp)
}