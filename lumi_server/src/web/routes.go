package web

import (
	"net/http"

	"github.com/Mahaveer86619/Lumi/src/handlers"
	"github.com/Mahaveer86619/Lumi/src/middleware"
	"github.com/Mahaveer86619/Lumi/src/types"
	"github.com/gorilla/mux"
)

// SetupRoutes sets up the routes for the application.
func SetupRoutes() *mux.Router {
	router := mux.NewRouter()

	// Public routes
	router.HandleFunc("/health", handlers.HealthHandler).Methods("GET")
	router.HandleFunc("/register", handlers.RegisterHandler).Methods("POST")
	router.HandleFunc("/login", handlers.LoginHandler).Methods("POST")
	router.HandleFunc("/refresh", handlers.RefreshTokenHandler).Methods("POST")

	// Protected routes
	api := router.PathPrefix("/api").Subrouter()
	api.Use(middleware.AuthMiddleware)

	api.HandleFunc("/users/all", handlers.GetAllUsersHandler).Methods("GET")
	api.HandleFunc("/users", handlers.GetUserByIDHandler).Methods("GET")
	api.HandleFunc("/users/email", handlers.GetUserByEmailHandler).Methods("GET")
	api.HandleFunc("/users", handlers.UpdateUserHandler).Methods("PUT")
	api.HandleFunc("/users", handlers.DeleteUserHandler).Methods("DELETE")

	router.NotFoundHandler = http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		failure := types.Failure{}
		failure.SetStatusCode(http.StatusNotFound)
		failure.SetMessage("API endpoint not found")
		failure.JSON(w)
	})

	return router
}
