package types

// User represents a user in the system	
type User struct {
	ID       uint   `json:"id" gorm:"primaryKey"`
	FullName string `json:"full_name"`
	Email    string `json:"email" gorm:"unique"`
	Password string `json:"-"`
}
