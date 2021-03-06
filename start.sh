#!/bin/bash

# (v3.7)
docker-compose \
-p personnal-docker-config \
--project-directory . \
-f reverse-proxy/docker-compose.yml \
-f monitoring/docker-compose.yml \
-f personnal-website/docker-compose.yml \
-f wiki/docker-compose.yml \
-f git/docker-compose.yml \
-f status/Docker/docker-compose.yml \
-f board/docker-compose.yml \
-f dns-update/docker-compose.yml \
-f ipam/docker-compose.yml \
-f apt-cache/docker-compose.yml \
up \
-d

# log + wifi-controller (v2.4)
docker-compose \
-p personnal-docker-config \
--project-directory . \
-f log/docker-compose.yml \
-f wifi-controller/docker-compose.yml \
up \
-d

# dns (v2.1)
docker-compose \
-p personnal-docker-config \
--project-directory . \
-f dns/docker-compose.yml \
up \
-d

# mail-server (v2)
cd mail-server/mailcow-dockerized/
docker-compose \
-p personnal-docker-config \
--project-directory . \
up \
-d
cd ../..

# automation (v2)
docker-compose \
-p personnal-docker-config \
--project-directory . \
-f automation/docker-compose.yml \
up \
-d