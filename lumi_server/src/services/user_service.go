package services

import (
	"github.com/Mahaveer86619/Lumi/src/database"
	"github.com/Mahaveer86619/Lumi/src/types"
	"github.com/Mahaveer86619/Lumi/src/utils"
)

func CreateUser(fullName, email, password string) (types.User, string, error) {
	hashedPassword, err := utils.HashPassword(password)
	if err != nil {
		utils.AppLogger.Error("Error hashing password: %v", err.Error())
		return types.User{}, "", err
	}

	user := types.User{
		ID:       utils.GenerateUUID(),
		FullName: fullName,
		Email:    email,
		Password: hashedPassword,
	}

	if err := database.DB.Save(&user).Error; err != nil {
		utils.AppLogger.Error("Error creating user: %v", err.Error())
		return types.User{}, "", err
	}

	return user, "User created successfully", nil
}

func GetAllUsers() ([]types.User, string, error) {
	var users []types.User
	if err := database.DB.Find(&users).Error; err != nil {
		utils.AppLogger.Error("Error retrieving all users: %v", err.Error())
		return nil, "", err
	}
	return users, "Users retrieved successfully", nil
}

func GetUserByEmail(email string) (types.User, string, error) {
	var user types.User

	if err := database.DB.Debug().Where("email = ?", email).First(&user).Error; err != nil {
		utils.AppLogger.Error("Error retrieving user by email: %v", err.Error())
		return types.User{}, "", err
	}

	return user, "User retrieved successfully", nil
}

func GetUserByID(id string) (types.User, string, error) {
	utils.AppLogger.Info("Fetching user with ID: %s", id)
	var user types.User
	if err := database.DB.Where("id = ?", id).First(&user).Error; err != nil {
		utils.AppLogger.Error("Error retrieving user by ID: %v", err.Error())
		return types.User{}, "", err
	}

	return user, "User retrieved successfully", nil
}

func UpdateUser(user types.UpdateUserRequest) (types.UserSafeResponse, string, error) {
	var existingUser types.User
	if err := database.DB.Where("id = ?", user.ID).First(&existingUser).Error; err != nil {
		utils.AppLogger.Error("Error retrieving user by ID: %v", err.Error())
		return types.UserSafeResponse{}, "user not found", err
	}

	existingUser.FullName = user.FullName
	existingUser.Email = user.Email

	if err := database.DB.Save(&existingUser).Error; err != nil {
		utils.AppLogger.Error("Error updating user: %v", err.Error())
		return types.UserSafeResponse{}, "", err
	}

	updatedUser := types.UserSafeResponse{
		ID:           existingUser.ID,
		FullName:     existingUser.FullName,
		Email:        existingUser.Email,
	}

	return updatedUser, "User updated successfully", nil
}

func VerifyUser(email string) (string, error) {
	user, msg, err := GetUserByEmail(email)
	if err != nil {
		return msg, err
	}

	user.IsVerified = true
	if err := database.DB.Save(&user).Error; err != nil {
		utils.AppLogger.Error("Error verifying user: %v", err.Error())
		return "", err
	}

	return "User verified successfully", nil
}

func DeleteUser(id string) (string, error) {
	var user types.User
	if err := database.DB.Where("id = ?", id).First(&user).Error; err != nil {
		utils.AppLogger.Error("Error retrieving user by ID: %v", err.Error())
		return "user not found", err
	}

	if err := database.DB.Delete(&user).Error; err != nil {
		utils.AppLogger.Error("Error deleting user: %v", err.Error())
		return "", err
	}

	return "User deleted successfully", nil
}
