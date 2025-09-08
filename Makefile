
# Default target: build and start containers
all: up

# Build Docker images and start containers
up:
	docker-compose up -d --build

# Stop containers
down:
	docker-compose down

# Stop containers and remove volumes (fresh start)
clean: 
	docker-compose down -v

# Restart containers
restart: down up

# Show running containers
ps:
	docker ps

# Tail logs of all containers
logs:
	docker-compose logs -f

# Enter a container shell
# Usage: make enter CONTAINER=wordpress
enter:
	docker exec -it $(CONTAINER) sh
