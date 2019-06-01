docker-compose \
-p personnal-docker-config \
--project-directory . \
-f reverse-proxy/docker-compose.yml \
-f personnal-website/docker-compose.yml \
-f bookstack/docker-compose.yml \
-f monitoring/docker-compose.yml \
up \
-d