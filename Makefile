.PHONY: all build up down restart logs clean

COMPOSE = srcs/docker-compose.yml

all: up

build:
	docker compose -f $(COMPOSE) build

up:
	docker compose -f $(COMPOSE) up -d

down:
	docker compose -f $(COMPOSE) down

restart: down up

logs:
	docker compose -f $(COMPOSE) logs -f

clean: down
	docker compose -f $(COMPOSE) down -v --remove-orphans

ps:
	docker compose -f $(COMPOSE) ps

exec-wp:
	docker exec -it wordpress /bin/bash

exec-nginx:
	docker exec -it nginx /bin/bash

exec-mariadb:
	docker exec -it mariadb /bin/bash