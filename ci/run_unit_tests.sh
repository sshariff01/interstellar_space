#!/usr/bin/env sh

set -ex

docker-compose build app

docker-compose run --service-ports app rake db:migrate

docker exec -it interstellar_space_app_run_1 rake test:unit

docker rm -f interstellar_space_app_run_1
