This is my personnal-docker-config, it will be depreciated when I will do my personnal-ansible-config.

# Requirement

- Docker compose with **Docker Engine >= 18.06.0+**

# Description

- Reverse proxy : Traefik
- Monitoring : Grafana/Prometheus/node-exporter/cadvisor/loki (https://monitoring.adminafk.fr)
- Personnal-website : homemade (https://ludovic-ortega.adminafk.fr, https://adminafk.fr)
	- server : Nginx
	- frontend : [Github repository link](https://github.com/M0NsTeRRR/Personnal-website/tree/master/frontend)
	- backend : [Github repository link](https://github.com/M0NsTeRRR/Personnal-website/tree/master/backend)
- Mail-server : Mailcow (https://mail.adminafk.fr)
- Wiki : Bookstack (https://wiki.adminafk.fr)
- VPN : WireGuard *incoming*
- Git : Gitlab *incoming*
- DHCP/DNS : Dnsmasq *incoming*

# Configuration

- Monitoring
	- fill `monitoring/grafana/prod.env` (template : monitoring/grafana/prod.env.example)
- Personnal-website
	- fill `personnal-website/backend/prod.env` (template : personnal-website/backend/prod.env.example)
- Mail-server
	- generate configuration file `./mail-server/generate_config.sh` (hostname = mail.adminafk.fr)
	- edit `./mail-server/mailcow.conf` with `SKIP_LETS_ENCRYPT=y`
- Wiki
	- fill `wiki/config/prod.env` (template : wiki/config/prod.env.example)
	- fill `wiki/config/prod_db.env` (template : wiki/config/prod_db.env.example)

# Launch

- Setup : `chmod +x setup.sh` and `./setup.sh`
- Start everything : `./start.sh`

# Credits

Copyright © Ludovic Ortega, 2019

Contributor(s):

-Ortega Ludovic - mastership@hotmail.fr