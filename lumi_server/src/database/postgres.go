package database

import (
	"fmt"
	"log"

	"github.com/Mahaveer86619/Lumi/src/config"
	"github.com/Mahaveer86619/Lumi/src/types"
	"github.com/Mahaveer86619/Lumi/src/utils"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var DB *gorm.DB

func ConnectDB() error {
	db, err := gorm.Open(postgres.Open(config.DB_DSN), &gorm.Config{})
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}

	utils.AppLogger.Info("Successfully connected to PostgreSQL database!")

	if db == nil {
		return fmt.Errorf("failed to connect to database")
	}

	DB = db
	return nil
}

func MigrateDB() error {
	err := DB.AutoMigrate(
		&types.User{},
	)
	if err != nil {
		return fmt.Errorf("failed to migrate database: %v", err)
	}
	utils.AppLogger.Info("Database migrated successfully")
	return nil
}

func SeedDB() error {

	hashedAdminPassword, err := utils.HashPassword("Password") // Hash the password
    if err != nil {
        return fmt.Errorf("failed to hash admin password: %v", err)
    }
    hashedMahaveerPassword, err := utils.HashPassword("Password") // Hash the password
    if err != nil {
        return fmt.Errorf("failed to hash mahaveer password: %v", err)
    }

	users := []types.User{
		{
			ID:       utils.GenerateUUID(),
			FullName: "Admin User",
			Email:    "admin@example.com",
			Password: hashedAdminPassword,
		},
		{
			ID:       utils.GenerateUUID(),
			FullName: "Mahaveer",
			Email:    "mahaveer@example.com",
			Password: hashedMahaveerPassword,
		},
	}

	for _, user := range users {
		if err := DB.Create(&user).Error; err != nil {
			return fmt.Errorf("failed to seed database: %v", err)
		}
	}

	utils.AppLogger.Info("Database seeded successfully")
	return nil
}
