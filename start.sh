docker-compose \
-p personnal-docker-config \
--project-directory . \
-f reverse-proxy/docker-compose.yml \
-f personnal-website/docker-compose.yml \
-f wiki/docker-compose.yml \
-f monitoring/docker-compose.yml \
up \
-d

docker-compose \
-p personnal-docker-config-mail-server \
--project-directory . \
-f mail-server/docker-compose.yml \
up \
-d