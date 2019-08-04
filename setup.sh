#!/bin/bash

# traefik
chmod 600 reverse-proxy/config/acme.json

chmod +x start.sh

# setup docker network
# 172.22.1.0/24 reserved to mailcow

docker network create \
--driver=bridge \
--subnet=172.22.2.0/24 \
--ip-range=172.22.2.0/24 \
--gateway=172.22.2.254 \
web

docker network create \
--driver=bridge \
--subnet=172.22.3.0/24 \
--ip-range=172.22.3.0/24 \
--gateway=172.22.3.254 \
proxy

docker network create \
--driver=bridge \
--subnet=172.22.4.0/24 \
--ip-range=172.22.4.0/24 \
--gateway=172.22.4.254 \
monitoring

docker network create \
--driver=bridge \
--subnet=172.22.5.0/24 \
--ip-range=172.22.5.0/24 \
--gateway=172.22.5.254 \
log

docker network create \
--driver=bridge \
--subnet=172.22.6.0/24 \
--ip-range=172.22.6.0/24 \
--gateway=172.22.6.254 \
personnal-website

docker network create \
--driver=bridge \
--subnet=172.22.7.0/24 \
--ip-range=172.22.7.0/24 \
--gateway=172.22.7.254 \
wiki

docker network create \
--driver=bridge \
--subnet=172.22.8.0/24 \
--ip-range=172.22.8.0/24 \
--gateway=172.22.8.254 \
git

docker network create \
--driver=bridge \
--subnet=172.22.9.0/24 \
--ip-range=172.22.9.0/24 \
--gateway=172.22.9.254 \
status