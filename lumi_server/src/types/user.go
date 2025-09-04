package types

// User represents a user in the system
type User struct {
	ID         string `json:"id" gorm:"primaryKey"`
	FullName   string `json:"full_name"`
	Email      string `json:"email" gorm:"unique"`
	Password   string `json:"-"`
	IsVerified bool   `json:"is_verified"`
}

type UserResponse struct {
	ID           string `json:"id"`
	FullName     string `json:"full_name"`
	Email        string `json:"email"`
	IsVerified   bool   `json:"is_verified"`
	Token        string `json:"token"`
	RefreshToken string `json:"refresh_token"`
}

type UserSafeResponse struct {
	ID       string `json:"id"`
	FullName string `json:"full_name"`
	Email    string `json:"email"`
	IsVerified   bool   `json:"is_verified"`
}

type UpdateUserRequest struct {
	ID       string `json:"id"`
	FullName string `json:"full_name"`
	Email    string `json:"email"`
}

type TokenRefreshRequest struct {
	RefreshToken string `json:"refresh_token"`
}

type Tokens struct {
	Token        string `json:"token"`
	RefreshToken string `json:"refresh_token"`
}
