.PHONY: start-db stop-db run migrate seed

DB_CONTAINER_NAME = lumi_db
DB_NAME = lumi
DB_USER = root
DB_PASSWORD = password
DB_PORT = 5432
DB_VOLUME_NAME = lumi_data
DB_IMAGE = postgres:latest

start-db:
	@echo "Starting PostgreSQL database container..."
	docker volume create $(DB_VOLUME_NAME) || true # Create volume if it doesn't exist
	docker run --name $(DB_CONTAINER_NAME) \
		-e POSTGRES_USER=$(DB_USER) \
		-e POSTGRES_PASSWORD=$(DB_PASSWORD) \
		-e POSTGRES_DB=$(DB_NAME) \
		-p $(DB_PORT):5432 \
		-v $(DB_VOLUME_NAME):/var/lib/postgresql/data \
		-d $(DB_IMAGE)
	@echo "PostgreSQL container '$(DB_CONTAINER_NAME)' started on port $(DB_PORT)."
	@echo "Data is persisted in Docker volume '$(DB_VOLUME_NAME)'."

stop-db:
	@echo "Stopping PostgreSQL database container '$(DB_CONTAINER_NAME)'..."
	docker stop $(DB_CONTAINER_NAME)
	docker rm $(DB_CONTAINER_NAME)
	@echo "PostgreSQL container '$(DB_CONTAINER_NAME)' stopped and removed."

run:
	@echo Running Go Server
	go run cmd/main.go

migrate:
	@echo Running Migrations
	go run cmd/migrate/main.go

seed:
	@echo Running Seed
	go run cmd/seed/main.go