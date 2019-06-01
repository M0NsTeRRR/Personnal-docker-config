chmod 600 reverse-proxy/config/acme.json
umask 022
chmod +x start.sh
docker network create web