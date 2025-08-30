package web

import (
	"net/http"

	"github.com/Mahaveer86619/Lumi/src/handlers"
	"github.com/Mahaveer86619/Lumi/src/middleware"
)

// SetupRoutes sets up the routes for the application.
func SetupRoutes() *http.ServeMux {
	mux := http.NewServeMux()
	protectedMux := http.NewServeMux()

	mux.HandleFunc("/health", handlers.HealthHandler)

	mux.HandleFunc("POST /register", handlers.RegisterHandler)
	mux.HandleFunc("POST /login", handlers.LoginHandler)
	mux.HandleFunc("POST /refresh", handlers.RefreshTokenHandler)

	protectedMux.HandleFunc("GET /users", handlers.GetAllUsersHandler)
	protectedMux.HandleFunc("GET /users/{id}", handlers.GetUserByIDHandler)
	protectedMux.HandleFunc("GET /users/email/{email}", handlers.GetUserByEmailHandler)
	protectedMux.HandleFunc("PUT /users/{id}", handlers.UpdateUserHandler)
	protectedMux.HandleFunc("DELETE /users/{id}", handlers.DeleteUserHandler)

	// Add authentication middleware to protected routes
	protectedHandler := middleware.AuthMiddleware(protectedMux)

	mux.Handle("/api", protectedHandler)

	return mux
}
