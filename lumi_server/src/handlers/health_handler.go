package handlers

import (
	"net/http"

	"github.com/Mahaveer86619/Lumi/src/services"
	"github.com/Mahaveer86619/Lumi/src/types"
)

func HealthHandler(w http.ResponseWriter, r *http.Request) {

	health, err := services.CheckHealth()
	if err != nil {
		failure := types.Failure{}
		failure.SetStatusCode(http.StatusInternalServerError)
		failure.SetMessage("Failed to check health")
		failure.JSON(w)
		return
	}

	success := types.Success{}
	success.SetStatusCode(http.StatusOK)
	success.SetMessage("Health check complete")
	success.SetData(health)
	success.JSON(w)
}