package types

// User represents a user in the system
type User struct {
	ID       string `json:"id" gorm:"primaryKey"`
	FullName string `json:"full_name"`
	Email    string `json:"email" gorm:"unique"`
	Password string `json:"-"`
}

type UserResponse struct {
	ID           string `json:"id"`
	FullName     string `json:"full_name"`
	Email        string `json:"email"`
	Token        string `json:"token"`
	RefreshToken string `json:"refresh_token"`
}

type TokenRefreshRequest struct {
	RefreshToken string `json:"refresh_token"`
}

type Tokens struct {
	Token        string `json:"token"`
	RefreshToken string `json:"refresh_token"`
}