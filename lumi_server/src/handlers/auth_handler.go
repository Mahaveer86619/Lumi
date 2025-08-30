package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/Mahaveer86619/Lumi/src/services"
	"github.com/Mahaveer86619/Lumi/src/types"
)

func RegisterHandler(w http.ResponseWriter, r *http.Request) {
	var req types.RegisterRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		failure := types.Failure{}
		failure.SetStatusCode(http.StatusBadRequest)
		failure.SetMessage(err.Error())
		failure.JSON(w)
		return
	}

	// Handle user registration
	user, status, err := services.RegisterUser(req)
	if err != nil {
		failure := types.Failure{}
		failure.SetStatusCode(status)
		failure.SetMessage(err.Error())
		failure.JSON(w)
		return
	}

	success := types.Success{}
	success.SetStatusCode(status)
	success.SetData(user)
	success.JSON(w)
}

func LoginHandler(w http.ResponseWriter, r *http.Request) {
	var req types.LoginRequest
	// Parse and validate the request
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		failure := types.Failure{}
		failure.SetStatusCode(http.StatusBadRequest)
		failure.SetMessage(err.Error())
		failure.JSON(w)
		return
	}

	// Handle user login
	user, status, err := services.AuthenticateUser(req)
	if err != nil {
		failure := types.Failure{}
		failure.SetStatusCode(status)
		failure.SetMessage(err.Error())
		failure.JSON(w)
		return
	}

	success := types.Success{}
	success.SetStatusCode(status)
	success.SetData(user)
	success.JSON(w)
}

func RefreshTokenHandler(w http.ResponseWriter, r *http.Request) {
	var req types.TokenRefreshRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		failure := types.Failure{}
		failure.SetStatusCode(http.StatusBadRequest)
		failure.SetMessage(err.Error())
		failure.JSON(w)
		return
	}

	// Handle token refresh
	user, status, err := services.RefreshToken(req)
	if err != nil {
		failure := types.Failure{}
		failure.SetStatusCode(status)
		failure.SetMessage(err.Error())
		failure.JSON(w)
		return
	}

	success := types.Success{}
	success.SetStatusCode(status)
	success.SetData(user)
	success.JSON(w)
}
