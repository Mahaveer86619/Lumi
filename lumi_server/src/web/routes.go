package web

import (
	"net/http"

	"github.com/Mahaveer86619/Lumi/src/handlers"
)

// SetupRoutes sets up the routes for the application.
func SetupRoutes() *http.ServeMux {
	mux := http.NewServeMux()

	mux.HandleFunc("/health", handlers.HealthHandler)

	mux.HandleFunc("POST /register", handlers.RegisterHandler)
	mux.HandleFunc("POST /login", handlers.LoginHandler)

	return mux
}
