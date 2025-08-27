package config

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

var (
	GEMINI_API_KEY string
	JWT_SECRET     string
	PORT           string
	DSN            string

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
	GEMINI_API_KEY = os.Getenv("GEMINI_API_KEY")
	JWT_SECRET = os.Getenv("JWT_SECRET")
	PORT = os.Getenv("PORT")

	DB_HOST = os.Getenv("DB_HOST")
	DB_PORT = os.Getenv("DB_PORT")
	DB_USER = os.Getenv("DB_USER")
	DB_PASSWORD = os.Getenv("DB_PASSWORD")
	DB_NAME = os.Getenv("DB_NAME")

	DB_DSN = DB_USER + ":" + DB_PASSWORD + "@tcp(" + DB_HOST + ":" + DB_PORT + ")/" + DB_NAME + "?charset=utf8mb4&parseTime=True&loc=Local"
}
