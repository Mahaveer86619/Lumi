package services

import "github.com/Mahaveer86619/Lumi/src/types"

func CheckHealth() (types.Health, error) {
	health := types.Health{
		Server: "OK",
	}
	return health, nil
}
