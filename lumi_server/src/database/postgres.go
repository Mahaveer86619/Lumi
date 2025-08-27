package database

import (
	"fmt"
	"log"

	"github.com/Mahaveer86619/Lumi/src/config"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

type DB struct {
	db *gorm.DB
}

func ConnectDB() (*DB, error) {
	db := InitDB()
	
	if db == nil {
		return nil, fmt.Errorf("failed to connect to database")
	}

	return &DB{
		db: db,
	}, nil
}

func InitDB() *gorm.DB {
	db, err := gorm.Open(postgres.Open(config.DB_DSN), &gorm.Config{})
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}

	log.Println("Successfully connected to PostgreSQL database!")
	return db
}
