This is my personnal-docker-config.

# Requirement

- Docker compose with **Docker Engine >= 18.06.0+**

# Description

- Reverse proxy : Traefik
- Monitoring : Grafana/Prometheus/node-exporter/cadvisor/loki (https://monitoring.adminafk.fr)
- Log : Graylog *incoming* (https://log.adminafk.fr)
- Personnal-website : homemade (https://ludovic-ortega.adminafk.fr, https://adminafk.fr)
	- server : Nginx
	- frontend : [Github repository link](https://github.com/M0NsTeRRR/Personnal-website/tree/master/frontend)
	- backend : [Github repository link](https://github.com/M0NsTeRRR/Personnal-website/tree/master/backend)
- Mail-server : Mailcow (https://mail.adminafk.fr)
- Wiki : Bookstack (https://wiki.adminafk.fr)
- VPN : WireGuard *incoming*
- Git : Gitea (https://git.adminafk.fr)
- DHCP/DNS : Dnsmasq *incoming*

# Configuration

- Monitoring
	- fill `monitoring/grafana/prod.env` (template : monitoring/grafana/prod.env.example)
- Personnal-website
	- fill `personnal-website/backend/prod.env` (template : personnal-website/backend/prod.env.example)
- Mail-server
	- `umask 022`
	- `git clone https://github.com/mailcow/mailcow-dockerized`
	- `mv docker-compose.override.yml mailcow-dockerized/ && cd mailcow-dockerized/`
	- remove http/https binded ports on `nginx-mailcow` container `nano docker-compose.yml`
	- generate configuration file `chmod +x generate_config.sh && ./generate_config.sh` (hostname = mail.adminafk.fr)
	- edit `nano mailcow.conf` with `SKIP_LETS_ENCRYPT=y`
- Wiki
	- fill `wiki/config/prod.env` (template : wiki/config/prod.env.example)
	- fill `wiki/config/prod_db.env` (template : wiki/config/prod_db.env.example)
- Git
	- fill `git/config/prod.env` (template : git/config/prod.env.example)
	- fill `git/config/prod_db.env` (template : git/config/prod_db.env.example)

# Exposed ports

- Reverse proxy
	- 80 (HTTP)
	- 443 (HTTPS)
- Mail-server
	- 110 (POP3 - Dovecot)
	- 25 (SMTP - Postfix)
	- 465 (SMTPS - Postfix)
	- 587 (Submission - Postfix)
	- 143 (IMAP - Dovecot)
	- 993 (IMAPS - Dovecot)
	- 995 (POP3S - Dovecot)
	- 4190 (ManageSieve - Dovecot)
- Git
	- 22 (SSH)

# Launch

- Setup : `chmod +x setup.sh && ./setup.sh`
- Start everything (no mailcow) : `./start.sh`
- Start mailcow : `cd mail-server/mailcow-dockerized/ && docker-compose up -d && cd ../..`
- Finish git install `https://git.adminafk.fr/install`

# Credits

Copyright © Ludovic Ortega, 2019

Contributor(s):

-Ortega Ludovic - mastership@hotmail.fr