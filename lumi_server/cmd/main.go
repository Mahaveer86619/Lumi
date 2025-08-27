package main

import (
	"log"

	"github.com/Mahaveer86619/Lumi/src/config"
	"github.com/Mahaveer86619/Lumi/src/database"
	"github.com/Mahaveer86619/Lumi/src/web"
)

func main() {
	err := config.Load()
	if err != nil {
		log.Fatal("Error loading config: ", err)
	}

	_, err = database.ConnectDB()
	if err != nil {
		log.Fatal("Error connecting to database: ", err)
	}

	server := web.NewServer()
	server.Init()
	server.Start()
}
