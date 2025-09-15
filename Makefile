PURPLE  = \033[1;38;5;99m
MAGENTA = \033[1;95m
CYAN    = \033[1;38;5;51m
GREEN   = \033[1;92m
YELLOW  = \033[1;93m
NC      = \033[0m

COMPOSE_FILE = ./srcs/docker-compose.yml
ENV_FILE     = ./srcs/.env
DATA_DIR     = /home/$(USER)/data

all: up

up:
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "$(PINK)Error: .env file missing at $(ENV_FILE)$(NC)"; \
		exit 1; \
	fi
	@echo "$(CYAN)Starting Inception project...$(NC)"
	@mkdir -p $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress $(DATA_DIR)/redis $(DATA_DIR)/website
	@docker compose -f $(COMPOSE_FILE) up --build -d
	@sleep 2
	@echo "$(PURPLE)All containers are now running!$(NC)"
	@echo "$(MAGENTA)WordPress:       https://$(USER).42.fr$(NC)"
	@echo "$(MAGENTA)WordPress Admin: https://$(USER).42.fr/wp-admin$(NC)"
	@echo "$(MAGENTA)Adminer:         http://rsham.42.fr:8080/adminer.php$(NC)"
	@echo "$(MAGENTA)cAdvisor:        https://cadvisor.rsham.42.fr$(NC)"
	@echo "$(MAGENTA)Website:         https://rsham.42.fr:8443$(NC)"

down:
	@echo "$(CYAN)Stopping containers...$(NC)"
	@docker compose -f $(COMPOSE_FILE) down
	@echo "$(GREEN)Containers stopped successfully$(NC)"

restart: down up

status:
	@echo "$(PURPLE)Current status of containers:$(NC)"
	@docker compose -f $(COMPOSE_FILE) ps
	@echo "$(CYAN)=== Networks ===$(NC)"
	@docker network ls
	@echo "$(CYAN)=== Volumes ===$(NC)"
	@docker volume ls
	@echo "$(PURPLE)Service Access URLs:$(NC)"
	@echo "$(MAGENTA)WordPress:       https://$(USER).42.fr$(NC)"
	@echo "$(MAGENTA)WordPress Admin: https://$(USER).42.fr/wp-admin$(NC)"
	@echo "$(MAGENTA)Adminer:         http://rsham.42.fr:8080/adminer.php$(NC)"
	@echo "$(MAGENTA)cAdvisor:        https://cadvisor.rsham.42.fr$(NC)"
	@echo "$(MAGENTA)Website:         https://rsham.42.fr:8443$(NC)"

%-shell:
	@if [ "$$(docker ps -q -f name=$*)" ]; then \
		docker exec -it $* sh || docker exec -it $* bash; \
	else \
		echo "$(YELLOW)Container '$*' is not running.$(NC)"; \
	fi

nginx: nginx-shell
wordpress: wordpress-shell
mariadb: mariadb-shell
redis: redis-shell
adminer: adminer-shell
ftp: ftp-shell
cadvisor: cadvisor-shell

clean:
	@echo "$(YELLOW)Cleaning up containers and temporary data...$(NC)"
	@docker compose -f $(COMPOSE_FILE) down -v
	@docker system prune -f
	@sudo rm -rf $(DATA_DIR)
	@echo "$(GREEN)Cleanup complete$(NC)"

fclean: clean
	@echo "$(PINK)Performing full cleanup - all Docker data will be removed!$(NC)"
	@docker compose -f $(COMPOSE_FILE) down -v --remove-orphans
	@docker system prune -af --volumes
	@sudo rm -rf $(DATA_DIR)
	@echo "$(GREEN)All data and containers fully removed$(NC)"

re: fclean up

start:
	@docker compose -f $(COMPOSE_FILE) start

stop:
	@docker compose -f $(COMPOSE_FILE) stop

.PHONY: all up down restart status \
	logs logs-% \
	nginx wordpress mariadb redis adminer ftp cadvisor \
	clean fclean re start stop %-shell

