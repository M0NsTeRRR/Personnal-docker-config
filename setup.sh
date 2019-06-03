chmod 600 reverse-proxy/config/acme.json
umask 022
chmod +x start.sh

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
--subnet=172.22.4.4/24 \
--ip-range=172.22.4.0/24 \
--gateway=172.22.4.254 \
monitoring

docker network create \
--driver=bridge \
--subnet=172.22.5.3/24 \
--ip-range=172.22.5.0/24 \
--gateway=172.22.5.254 \
personnal-website

docker network create \
--driver=bridge \
--subnet=172.22.6.3/24 \
--ip-range=172.22.6.0/24 \
--gateway=172.22.6.254 \
wiki