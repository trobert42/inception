# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: trobert <trobert@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/09 15:01:38 by trobert           #+#    #+#              #
#    Updated: 2023/02/25 14:36:59 by trobert          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

YML_FILE := 			srcs/docker-compose.yml
DOCKER_VOLUME_LIST :=	$(shell docker volume ls -q)

all: volumes build

volumes:
	mkdir -p ${HOME}/data/mariadb
	mkdir -p ${HOME}/data/wordpress

build:
	docker compose -f $(YML_FILE) build

up:
	docker compose -f $(YML_FILE) up

stop:
	docker compose -f $(YML_FILE) stop

re: fclean all

clean: stop
	docker compose -f $(YML_FILE) down

fclean: clean
	sudo rm -rf ${HOME}/data/mariadb
	sudo rm -rf ${HOME}/data/wordpress
	docker system prune -a -f
	@if [ -n "$(DOCKER_VOLUME_LIST)" ]; then docker volume rm $(DOCKER_VOLUME_LIST) ; fi
	@echo "Cleaning: success!"

	
.PHONY: clean fclean all re
