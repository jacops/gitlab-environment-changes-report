.DEFAULT_GOAL := build

build:
	docker-compose build app

setup:
	cp -n .env.dist .env

run:
	docker-compose run --rm app