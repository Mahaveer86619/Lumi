package services

import (
	"errors"
	"net/http"
	"net/smtp"

	"github.com/Mahaveer86619/Lumi/src/config"
	"github.com/Mahaveer86619/Lumi/src/middleware"
	"github.com/Mahaveer86619/Lumi/src/types"
	"github.com/Mahaveer86619/Lumi/src/utils"
)

var (
	ErrUserAlreadyExists   = errors.New("user already exists")
	ErrInternalServerError = errors.New("internal server error")
	ErrInvalidCredentials  = errors.New("invalid email or password")
)

func RegisterUser(req types.RegisterRequest) (types.UserResponse, int, error) {
	_, _, err := GetUserByEmail(req.Email)
	if err == nil {
		return types.UserResponse{}, http.StatusConflict, ErrUserAlreadyExists
	}

	// Save the user to the database
	user, _, err := CreateUser(req.FullName, req.Email, req.Password)
	if err != nil {
		return types.UserResponse{}, http.StatusInternalServerError, err
	}

	// Generate a token for the user
	token, err := middleware.GenerateToken()
	if err != nil {
		return types.UserResponse{}, http.StatusInternalServerError, err
	}

	refreshToken, err := middleware.GenerateRefreshToken()
	if err != nil {
		return types.UserResponse{}, http.StatusInternalServerError, err
	}

	response := types.UserResponse{
		ID:           user.ID,
		FullName:     user.FullName,
		Email:        user.Email,
		Token:        token,
		RefreshToken: refreshToken,
	}

	return response, http.StatusCreated, nil
}

func AuthenticateUser(req types.LoginRequest) (types.UserResponse, int, error) {
	user, _, err := GetUserByEmail(req.Email)
	if err != nil {
		return types.UserResponse{}, http.StatusUnauthorized, ErrInvalidCredentials
	}

	// Verify the password
	if !utils.CheckPasswordHash(req.Password, user.Password) {
		return types.UserResponse{}, http.StatusUnauthorized, ErrInvalidCredentials
	}

	// Generate a token for the user
	token, err := middleware.GenerateToken()
	if err != nil {
		return types.UserResponse{}, http.StatusInternalServerError, ErrInternalServerError
	}

	refreshToken, err := middleware.GenerateRefreshToken()
	if err != nil {
		return types.UserResponse{}, http.StatusInternalServerError, ErrInternalServerError
	}

	response := types.UserResponse{
		ID:           user.ID,
		FullName:     user.FullName,
		Email:        user.Email,
		Token:        token,
		RefreshToken: refreshToken,
	}

	return response, http.StatusOK, nil
}

func RefreshToken(req types.TokenRefreshRequest) (types.Tokens, int, error) {
	// Validate the refresh token
	tokens, err := middleware.RefreshToken(req.RefreshToken)
	if err != nil {
		utils.AppLogger.Error("Failed to refresh token: %v", err)
		return types.Tokens{}, http.StatusUnauthorized, ErrInvalidCredentials
	}

	return tokens, http.StatusOK, nil
}

func SendVerificationEmail(req types.EmailRequest) (int, error) {
	from := config.GMAIL
	password := config.GMAIL_APP_PASS
	host := config.SMTP_HOST
	port := config.SMTP_PORT

	to := req.Email
	secret := []byte(config.FP_SECRET)

	otp, err := GenerateOTP(secret, to)
	if err != nil {
		utils.AppLogger.Error("Failed to generate otp: %v", err)
		return http.StatusInternalServerError, ErrInternalServerError
	}

	subject := "Email Verification"
	body := utils.GenerateHTMLBody(otp)

	msg := []byte("From: " + from + "\r\n" +
		"To: " + to + "\r\n" +
		"Subject: " + subject + "\r\n" +
		"MIME-Version: 1.0\r\n" +
		"Content-Type: text/html; charset=\"UTF-8\"\r\n" +
		"\r\n" +
		body)

	auth := smtp.PlainAuth("", from, password, host)

	err = smtp.SendMail(host+":"+port, auth, from, []string{to}, msg)
	if err != nil {
		utils.AppLogger.Error("Failed to send email to %s: %v", to, err)
		return http.StatusInternalServerError, ErrInternalServerError 
	}
	return http.StatusOK, nil
}

func verifyOTPFromEmail(req type.) {

}