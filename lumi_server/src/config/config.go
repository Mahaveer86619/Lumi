package config

import (
	"log"
	"os"

	"github.com/Mahaveer86619/Lumi/src/utils"
	"github.com/joho/godotenv"
)

var (
	GEMINI_API_KEY string
	JWT_SECRET     string
	PORT           string

	DB_HOST     string
	DB_PORT     string
	DB_USER     string
	DB_PASSWORD string
	DB_NAME     string
	DB_DSN      string
)

func Load() error {
	err := godotenv.Load()
	if err != nil {
		log.Println("No .env file found or error loading .env file")
		return err
	}

	updateGlobals()

	log.Println("Environment variables loaded successfully")
	return nil
}

func updateGlobals() {
	GEMINI_API_KEY = getEnv("GEMINI_API_KEY", "")
	JWT_SECRET = getEnv("JWT_SECRET", "")
	PORT = getEnv("PORT", "8080")

	DB_HOST = getEnv("DB_HOST", "localhost")
	DB_PORT = getEnv("DB_PORT", "5432")
	DB_USER = getEnv("DB_USER", "root")
	DB_PASSWORD = getEnv("DB_PASSWORD", "password")
	DB_NAME = getEnv("DB_NAME", "lumi")

	DB_DSN = "postgresql://" + DB_USER + ":" + DB_PASSWORD + "@" + DB_HOST + ":" + DB_PORT + "/" + DB_NAME + "?sslmode=disable"

	utils.AppLogger.Info("Database connection string: %s", DB_DSN)
}

func getEnv(key string, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		log.Printf("Warning: Environment variable '%s' is not set", key)
		return defaultValue
	}
	return value
}
