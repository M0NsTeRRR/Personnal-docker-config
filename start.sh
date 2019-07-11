#!/bin/bash

docker-compose \
-p personnal-docker-config \
--project-directory . \
-f reverse-proxy/docker-compose.yml \
-f monitoring/docker-compose.yml \
-f personnal-website/docker-compose.yml \
-f wiki/docker-compose.yml \
-f git/docker-compose.yml \
up \
-d

cd mail-server/mailcow-dockerized/
docker-compose \
-p personnal-docker-config \
--project-directory ../.. \
-f docker-compose.yml \
up \
-d
cd ../..

docker-compose \
-p personnal-docker-config \
--project-directory . \
-f log/docker-compose.yml \
up \
-d
