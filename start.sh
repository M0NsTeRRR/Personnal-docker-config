docker-compose \
-p personnal-docker-config \
--project-directory . \
-f reverse-proxy/docker-compose.yml \
-f personnal-website/docker-compose.yml \
-f wiki/docker-compose.yml \
-f monitoring/docker-compose.yml \
up \
-d

cd mail-server
docker-compose up -d
cd ..
