package main

import (
	"log"

	"github.com/Mahaveer86619/Lumi/src/config"
	"github.com/Mahaveer86619/Lumi/src/database"
)

func main() {
	err := config.Load()
	if err != nil {
		log.Fatal("Error loading config: ", err)
	}

	err = database.ConnectDB()
	if err != nil {
		log.Fatal("Error connecting to database: ", err)
	}

	err = database.SeedDB()
	if err != nil {
		log.Fatal("Error seeding database: ", err)
	}
}
