[![Codacy Badge](https://api.codacy.com/project/badge/Grade/69e259dc570b47b09fcc71b603842863)](https://app.codacy.com/app/M0NsTeRRR/Personnal-docker-config?utm_source=github.com&utm_medium=referral&utm_content=M0NsTeRRR/Personnal-docker-config&utm_campaign=Badge_Grade_Dashboard)

This is my personnal-docker-config.

# Status

| Websites        | Status           | Uptime  |
| ------------- |:-------------:| -----:|
| [Personnal-website](https://ludovic-ortega.adminafk.fr) | ![Uptime Robot status](https://img.shields.io/uptimerobot/status/m783222469-12d94c11dba41aed46ce378f?style=flat-square) | ![Uptime Robot ratio (30 days)](https://img.shields.io/uptimerobot/ratio/m783222469-12d94c11dba41aed46ce378f?style=flat-square)
| [Mail-server](https://mail.adminafk.fr) | ![Uptime Robot status](https://img.shields.io/uptimerobot/status/m783222478-f6ddda399cf297b69f816685?style=flat-square) | ![Uptime Robot ratio (30 days)](https://img.shields.io/uptimerobot/ratio/m783222478-f6ddda399cf297b69f816685?style=flat-square)
| [Wiki](https://wiki.adminafk.fr) | ![Uptime Robot status](https://img.shields.io/uptimerobot/status/m783222480-fdce5de8f21972139c93fea4?style=flat-square) | ![Uptime Robot ratio (30 days)](https://img.shields.io/uptimerobot/ratio/m783222480-fdce5de8f21972139c93fea4?style=flat-square)
| [Git](https://git.adminafk.fr) | ![Uptime Robot status](https://img.shields.io/uptimerobot/status/m783222482-af777491dc23d4d5635d4709?style=flat-square) | ![Uptime Robot ratio (30 days)](https://img.shields.io/uptimerobot/ratio/m783222482-af777491dc23d4d5635d4709?style=flat-square)
| [Status](https://status.adminafk.fr) | ![Uptime Robot status](https://img.shields.io/uptimerobot/status/m783222483-561a3c98cf377ede6eac1648?style=flat-square) | ![Uptime Robot ratio (30 days)](https://img.shields.io/uptimerobot/ratio/m783222483-561a3c98cf377ede6eac1648?style=flat-square)
| [Monitoring](https://monitoring.adminafk.fr) | ![Uptime Robot status](https://img.shields.io/uptimerobot/status/m783222475-0347e46cdbe638245ea6f97b?style=flat-square) | ![Uptime Robot ratio (30 days)](https://img.shields.io/uptimerobot/ratio/m783222475-0347e46cdbe638245ea6f97b?style=flat-square)
| [Log](https://log.adminafk.fr) | ![Uptime Robot status](https://img.shields.io/uptimerobot/status/m783222476-a0725d897e53a6762add2d31?style=flat-square) | ![Uptime Robot ratio (30 days)](https://img.shields.io/uptimerobot/ratio/m783222476-a0725d897e53a6762add2d31?style=flat-square)

# Requirements

- Docker compose with **Docker Engine >= 18.06.0+**

- Automation
	- Ansible

# Description

- Reverse proxy : Traefik
- Monitoring : Grafana/Prometheus/node-exporter/cadvisor/loki (https://monitoring.adminafk.fr)
- Log : Graylog (https://log.adminafk.fr)
- Personnal-website : homemade (https://ludovic-ortega.adminafk.fr, https://adminafk.fr)
	- server : Nginx
	- frontend : [Github repository link](https://github.com/M0NsTeRRR/Personnal-website/tree/master/frontend)
	- backend : [Github repository link](https://github.com/M0NsTeRRR/Personnal-website/tree/master/backend)
- Mail-server : Mailcow (https://mail.adminafk.fr)
- Wiki : Bookstack (https://wiki.adminafk.fr)
- Git : Gitea (https://git.adminafk.fr)
- Automation : Ansible AWX [LAN](http://<IP_VM:8000>)
- Status : Cachet (https://status.adminafk.fr)
- VPN : WireGuard *incoming*
- DHCP/DNS : Dnsmasq *incoming*
- Dns-update : homemade [Github repository link](https://github.com/M0NsTeRRR/DNSUpdateOVH)

# Configuration

- Monitoring
	- fill `monitoring/grafana/prod.env` (template : monitoring/grafana/prod.env.example)
	- fill `monitoring/influxdb/prod.env` (template : monitoring/influxdb/prod.env.example)
- Log
	- fill `log/config/prod.env` (template : log/config/prod.env.example)
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
- Automation
	- `git clone https://github.com/ansible/awx.git automation`
	- edit `nano automation/installer/inventory` :
		- host_port = 8000
		- admin_password = myAwesomePassword
		- docker_compose_dir = /app/Personnal-docker-config/automation/
	- build `cd automation/installer && ansible-playbook -i inventory install.yml && cd ../..`
	- when build is ended (docker logs -f awx_task) update `automation/docker-compose.yml` and update `restart: always` on all containers
- Status
	- `cd status && git clone https://github.com/CachetHQ/Docker`
	- fill environment variables `nano docker-compose.yml`
	- `rm Docker/docker-compose.yml && cp docker-compose.yml Docker/`
	- build and start the containers and edit environment variable `APP_KEY` with the value provided by the container `nano Docker/docker-compose.yml`
	- restart the container
	- After the setup on the website put this labels on the `docker-compose.yml` and restart the container
		- `traefik.backend.healthcheck.hostname=status.adminafk.fr`
      	- `traefik.backend.healthcheck.path=/`
      	- `traefik.backend.healthcheck.intervals=10s`
- Dns-update
	- fill `dns-update/config/prod.env` (template : dns-update/config/prod.env.example)

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

# Usage
- Finish Git install `https://git.adminafk.fr/install`
- Finish Wiki install `https://wiki.adminafk.fr/` (default: admin@admin.com/password)
- Finish Mail-server install `https://wiki.adminafk.fr/` (default: admin/moohoo)
- Finish Status install `https://status.adminafk.fr/setup`

# Credits

Copyright © Ludovic Ortega, 2019

Contributor(s):

-Ortega Ludovic - mastership@hotmail.fr