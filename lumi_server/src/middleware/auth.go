package middleware

import (
	"context"
	"errors"
	"net/http"
	"strings"
	"time"

	"github.com/Mahaveer86619/Lumi/src/config"
	"github.com/Mahaveer86619/Lumi/src/types"
	"github.com/Mahaveer86619/Lumi/src/utils"
	"github.com/golang-jwt/jwt/v5"
)

type contextKey string

const userContextKey = contextKey("user")

type Claims struct {
	jwt.MapClaims
}

var JwtKey []byte

func AuthMiddleware(next http.Handler) http.Handler {
	if len(JwtKey) == 0 {
		JwtKey = []byte(config.JWT_SECRET)
	}
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		authHeader := r.Header.Get("Authorization")
		if authHeader == "" {
			utils.AppLogger.Error("Missing Authorization header")
			failureResponse := types.Failure{}
			failureResponse.SetStatusCode(http.StatusUnauthorized)
			failureResponse.SetMessage("Authorization header is required")
			failureResponse.JSON(w)
			return
		}

		tokenString := strings.TrimPrefix(authHeader, "Bearer ")
		claims := &Claims{}
		token, err := jwt.ParseWithClaims(tokenString, claims, func(token *jwt.Token) (interface{}, error) {
			if len(JwtKey) == 0 {
				utils.AppLogger.Error("JWT secret key is empty")
				return nil, errors.New("invalid JWT secret key")
			}
			return JwtKey, nil
		})

		if err != nil {
			utils.AppLogger.Error("Failed to parse JWT token: %v", err)
			failureResponse := types.Failure{}
			failureResponse.SetStatusCode(http.StatusUnauthorized)
			failureResponse.SetMessage("Invalid token")
			failureResponse.JSON(w)
			return
		}

		if !token.Valid {
			utils.AppLogger.Error("Invalid JWT token")
			failureResponse := types.Failure{}
			failureResponse.SetStatusCode(http.StatusUnauthorized)
			failureResponse.SetMessage("Invalid token")
			failureResponse.JSON(w)
			return
		}

		ctx := context.WithValue(r.Context(), userContextKey, claims)
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}

func UserFromContext(ctx context.Context) (*Claims, bool) {
	if len(JwtKey) == 0 {
		JwtKey = []byte(config.JWT_SECRET)
	}

	claims, ok := ctx.Value(userContextKey).(*Claims)
	if !ok {
		utils.AppLogger.Error("Failed to retrieve claims from context")
		return nil, false
	}
	utils.AppLogger.Info("Retrieved claims from context: %+v", claims)
	return claims, ok
}

func RefreshToken(tokenString string) (types.Tokens, error) {
	if len(JwtKey) == 0 {
		JwtKey = []byte(config.JWT_SECRET)
	}

	claims := &Claims{}
	token, err := jwt.ParseWithClaims(tokenString, claims, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			utils.AppLogger.Error("Unexpected signing method: %v", token.Header["alg"])
			return nil, errors.New("invalid signing method")
		}
		if len(JwtKey) == 0 {
			utils.AppLogger.Error("JWT secret key is empty")
			return nil, errors.New("invalid JWT secret key")
		}
		return JwtKey, nil
	})
	if err != nil {
		utils.AppLogger.Error("Failed to parse refresh token: %v", err)
		return types.Tokens{}, err
	}
	if !token.Valid {
		utils.AppLogger.Error("Invalid refresh token")
		return types.Tokens{}, jwt.ErrSignatureInvalid
	}

	newToken, newRefreshToken, err := GenerateTokens()
	if err != nil {
		utils.AppLogger.Error("Failed to generate new tokens: %v", err)
		return types.Tokens{}, err
	}

	return types.Tokens{
		Token:        newToken,
		RefreshToken: newRefreshToken,
	}, nil
}

func GenerateTokens() (string, string, error) {
	if len(JwtKey) == 0 {
		JwtKey = []byte(config.JWT_SECRET)
	}
	token, err := GenerateToken()
	if err != nil {
		utils.AppLogger.Error("Failed to generate access token: %v", err)
		return "", "", err
	}

	refreshToken, err := GenerateRefreshToken()
	if err != nil {
		utils.AppLogger.Error("Failed to generate refresh token: %v", err)
		return "", "", err
	}

	utils.AppLogger.Info("Successfully generated access and refresh tokens")
	return token, refreshToken, nil
}

func GenerateToken() (string, error) {
	if len(JwtKey) == 0 {
		JwtKey = []byte(config.JWT_SECRET)
	}
	if len(config.JWT_SECRET) == 0 {
		utils.AppLogger.Error("JWT_SECRET is empty")
		return "", errors.New("JWT secret key is not configured")
	}

	expirationTime := time.Now().Add(25 * time.Hour)
	claims := &Claims{
		MapClaims: jwt.MapClaims{
			"exp": expirationTime.Unix(),
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	signedToken, err := token.SignedString([]byte(config.JWT_SECRET))
	if err != nil {
		utils.AppLogger.Error("Failed to sign access token: %v", err)
		return "", err
	}
	return signedToken, nil
}

func GenerateRefreshToken() (string, error) {
	if len(JwtKey) == 0 {
		JwtKey = []byte(config.JWT_SECRET)
	}

	expirationTime := time.Now().Add(721 * time.Hour)
	claims := &Claims{
		MapClaims: jwt.MapClaims{
			"exp": expirationTime.Unix(),
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	signedToken, err := token.SignedString([]byte(config.JWT_SECRET))
	if err != nil {
		utils.AppLogger.Error("Failed to sign refresh token: %v", err)
		return "", err
	}
	return signedToken, nil
}	