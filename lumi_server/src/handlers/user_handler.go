package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/Mahaveer86619/Lumi/src/services"
	"github.com/Mahaveer86619/Lumi/src/types"
)

func GetAllUsersHandler(w http.ResponseWriter, r *http.Request) {
	users, msg, err := services.GetAllUsers()
	if err != nil {
		failure := types.Failure{}
		failure.SetStatusCode(http.StatusInternalServerError)
		failure.SetMessage(err.Error())
		failure.JSON(w)
		return
	}

	success := types.Success{}
	success.SetData(users)
	success.SetStatusCode(http.StatusOK)
	success.SetMessage(msg)
	success.JSON(w)
}

func GetUserByIDHandler(w http.ResponseWriter, r *http.Request) {
	userId := r.URL.Query().Get("id")
	if userId == "" {
		failure := types.Failure{}
		failure.SetStatusCode(http.StatusBadRequest)
		failure.SetMessage("User ID is required")
		failure.JSON(w)
		return
	}

	user, msg, err := services.GetUserByID(userId)
	if err != nil {
		failure := types.Failure{}
		failure.SetStatusCode(http.StatusInternalServerError)
		failure.SetMessage(msg)
		failure.JSON(w)
		return
	}

	success := types.Success{}
	success.SetData(user)
	success.SetStatusCode(http.StatusOK)
	success.SetMessage("User retrieved successfully")
	success.JSON(w)
}

func GetUserByEmailHandler(w http.ResponseWriter, r *http.Request) {
	email := r.URL.Query().Get("email")
	if email == "" {
		failure := types.Failure{}
		failure.SetStatusCode(http.StatusBadRequest)
		failure.SetMessage("Email is required")
		failure.JSON(w)
		return
	}

	user, msg, err := services.GetUserByEmail(email)
	if err != nil {
		failure := types.Failure{}
		failure.SetStatusCode(http.StatusInternalServerError)
		failure.SetMessage(msg)
		failure.JSON(w)
		return
	}

	success := types.Success{}
	success.SetData(user)
	success.SetStatusCode(http.StatusOK)
	success.SetMessage("User retrieved successfully")
	success.JSON(w)
}

func UpdateUserHandler(w http.ResponseWriter, r *http.Request) {
	var user types.UpdateUserRequest
	if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
		failure := types.Failure{}
		failure.SetStatusCode(http.StatusBadRequest)
		failure.SetMessage("Invalid request payload")
		failure.JSON(w)
		return
	}

	updatedUser, msg, err := services.UpdateUser(user)
	if err != nil {
		failure := types.Failure{}
		failure.SetStatusCode(http.StatusInternalServerError)
		failure.SetMessage(msg)
		failure.JSON(w)
		return
	}

	success := types.Success{}
	success.SetData(updatedUser)
	success.SetStatusCode(http.StatusOK)
	success.SetMessage("User updated successfully")
	success.JSON(w)
}

func DeleteUserHandler(w http.ResponseWriter, r *http.Request) {
	userId := r.URL.Query().Get("id")
	if userId == "" {
		failure := types.Failure{}
		failure.SetStatusCode(http.StatusBadRequest)
		failure.SetMessage("User ID is required")
		failure.JSON(w)
		return
	}

	msg, err := services.DeleteUser(userId)
	if err != nil {
		if msg == "user not found" {
			failure := types.Failure{}
			failure.SetStatusCode(http.StatusNotFound)
			failure.SetMessage(msg)
			failure.JSON(w)
			return
		}
		failure := types.Failure{}
		failure.SetStatusCode(http.StatusInternalServerError)
		failure.SetMessage(msg)
		failure.JSON(w)
		return
	}

	success := types.Success{}
	success.SetData(nil)
	success.SetStatusCode(http.StatusOK)
	success.SetMessage("User deleted successfully")
	success.JSON(w)
}
