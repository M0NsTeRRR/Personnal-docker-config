### This project has been replaced by -> https://github.com/M0NsTeRRR/Homelab-infra

This is my personnal-docker-config.

# Requirements

- Docker with **Docker Engine >= 18.06.0+**

- Docker-compose

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
- Wiki : Wiki.js (https://wiki.adminafk.fr)
- Git : Gitea (https://git.adminafk.fr)
- Automation : Ansible AWX (https://automation.adminafk.fr)
- Status : Cachet (https://status.adminafk.fr)
- Board : Restya (https://board.adminafk.fr)
- Pastebin : PrivateBin (https://pastebin.adminafk.fr)
- IPAM : Nipap (https://ipam.adminafk.fr)
- Dns-update : homemade [Github repository link](https://github.com/M0NsTeRRR/DNSUpdateOVH)
- Tplink-smartplug : homemade [Github repository link](https://github.com/M0NsTeRRR/tplink-smartplug-influxdb)
- Wifi controller : Unifi [LAN](http://192.168.10.51:8443/)
- DNS : PowerDNS [LAN](http://192.168.10.51:9191/)
- Apt cache : apt-cacher-ng [LAN](http://192.168.10.51:3142/)

# Configuration

- Monitoring
	- fill `monitoring/grafana/prod.env` (template : monitoring/grafana/prod.env.example)
	- fill `monitoring/grafana/provisioning/datasources/default.yaml` (template : monitoring/grafana/provisioning/datasources/default.yaml.example)
	- fill `monitoring/influxdb/prod.env` (template : monitoring/influxdb/prod.env.example)
	- fill `monitoring/unifi-poller/up.conf` (template : monitoring/unifi-poller/up.conf.example)
	- Create database on InfluxDB
		```
		docker exec -it influxdb /bin/sh
		influx -host localhost -port 8086
		CREATE DATABASE unifi
		CREATE USER unifi WITH PASSWORD 'MyAwesomePassword'
		GRANT WRITE ON unifi TO unifi
		CREATE USER grafana WITH PASSWORD 'MyAwesomePassword'
		GRANT READ ON unifi TO grafana
		```
- Log
	- fill `log/config/prod.env` (template : log/config/prod.env.example)
- Personnal-website
	- fill `personnal-website/backend/prod.env` (template : personnal-website/backend/prod.env.example)
	- start the container and log into it :
		- Create the database `python3 manage.py makemigrations && python3 manage.py migrate`
		- Collect static file `python3 manage.py collectstatic --no-input`
- Mail-server
	- `cd mail-server && umask 022`
	- `git clone https://github.com/mailcow/mailcow-dockerized`
	- `cp docker-compose.override.yml mailcow-dockerized/ && cd mailcow-dockerized/`
	- remove http/https binded ports on `nginx-mailcow` container `nano docker-compose.yml`
	- generate configuration file `chmod +x generate_config.sh && ./generate_config.sh` (hostname = mail.adminafk.fr)
	- edit `nano mailcow.conf` with `SKIP_LETS_ENCRYPT=y`
	- finish Mail-server install `https://mail.adminafk.fr/` (default: admin/moohoo)
	- Create this emails : 
		- admin@adminafk.fr
		- contact@adminafk.fr
		- ludovic-ortega@adminafk.fr
		- monitoring@adminafk.fr
		- git@adminafk.fr
		- noreply@adminafk.fr
		- wifi@adminafk.fr
		- board@adminafk.fr
		- nas@adminafk.fr
		- wiki@adminafk.fr
- Wiki
	- fill `wiki/config/prod.env` (template : wiki/config/prod.env.example)
	- fill `wiki/config/prod_db.env` (template : wiki/config/prod_db.env.example)
	- finish Wiki install `https://wiki.adminafk.fr/` 
- Git
	- fill `git/config/prod.env` (template : git/config/prod.env.example)
	- fill `git/config/prod_db.env` (template : git/config/prod_db.env.example)
	- finish Git install `https://git.adminafk.fr/install`
- Automation
	- `git clone https://github.com/ansible/awx.git automation`
	- generate a secret key `openssl rand -hex 32`
	- edit `nano automation/installer/inventory` :
		- host_port=8000
		- admin_password=myAwesomePassword
		- docker_compose_dir="/app/Personnal-docker-config/automation/"
		- secret_key=<YOUR_SECRET>
	- build `cd automation/installer && ansible-playbook -i inventory install.yml && cd ../..`
	- when build is ended (docker logs -f awx_task) update `automation/docker-compose.yml` with the following :
		- Update compose file version to 3.7
		- Remove `ports:` directive on awx_web
		- Add `labels:` directive to awx_web with this :
			```
			- traefik.backend=automation
			- traefik.frontend.rule=Host:automation.adminafk.fr
			- traefik.docker.network=proxy
			- traefik.port=8052
			- traefik.enable=true
			- traefik.frontend.rateLimit.rateSet.standard.period=10
			- traefik.frontend.rateLimit.rateSet.standard.average=150
			- traefik.frontend.rateLimit.rateSet.standard.burst=300
			- traefik.backend.healthcheck.hostname=automation.adminafk.fr
			- traefik.backend.healthcheck.path=/#/login
			- traefik.backend.healthcheck.intervals=10s
			```
		- Add network `proxy` to awx web and network `automation` to all containers
		- Update directive `restart: always` to all containers
		- At the end of the docker compose add networks specification :
			```
			networks:
			  proxy:
			    external:
		          name: proxy
			  automation:
			    external:
			      name: automation
			```
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
	- finish Status install `https://status.adminafk.fr/setup`
- Board
	- fill `board/config/prod.env` (template : board/config/prod.env.example)
	- fill `board/config/prod_db.env` (template : board/config/prod_db.env.example)
- IPAM
	- fill `ipam/config/prod.env` (template : ipam/config/prod.env.example)
	- fill `ipam/config/prod_db.env` (template : ipam/config/prod_db.env.example)
	- fill `ipam/config/prod_www.env` (template : ipam/config/prod_www.env.example)
- Dns-update
	- fill `dns-update/config/prod.env` (template : dns-update/config/prod.env.example)
- Tplink-smartplug
	- fill `monitoring/tplink-smartplug/config/prod.env` (template : monitoring/tplink-smartplug/config/prod.env.example)
	- Create database on InfluxDB
		```
		docker exec -it influxdb /bin/sh
		influx -host localhost -port 8086
		CREATE DATABASE tplinksmartplug
		CREATE USER tplinksmartplug WITH PASSWORD 'MyAwesomePassword'
		GRANT WRITE ON tplinksmartplug TO tplinksmartplug
		```
- Wifi controller
	- Go on `http://192.168.10.51:8000/` (default : ubnt/ubnt)
	- In `Settings > Site > Services` disable Uplink Connectivity Monitor
	- In `Settings > Controller > Controller Settings` set controller IP with `192.168.10.51` and set mail server config
	- In `Settings > Admins` create an user `influxdb` to monitor Unifi
	- In `Settings > Wireless Networks` add all networks (VLAN 40 without VLAN tag)
	- To adopt a new UAP, adopt it on the webpanel and
		```
		ssh ubnt@<IP_UAP>
		set-inform http://192.168.10.51:8000/inform
		```
- DNS
	- fill `dns/config/prod_pdns-postgresql.env` (template : dns/config/prod_pdns-postgresql.env.example)
	- fill `dns/config/prod_pdns-server.env` (template : dns/config/prod_pdns-server.env.example)
	- fill `dns/config/prod_powerdns-admin-postgresql.env` (template : dns/config/prod_powerdns-admin-postgresql.env.example)
	- fill `dns/config/prod_powerdns-admin.env` (template : dns/config/prod_powerdns-admin.env.example)	

# Exposed ports

- Reverse proxy
	- 80 (HTTP) - TCP
	- 443 (HTTPS) - TCP
- Mail-server
	- 110 (POP3 - Dovecot) - TCP
	- 25 (SMTP - Postfix) - TCP
	- 465 (SMTPS - Postfix) - TCP
	- 587 (Submission - Postfix) - TCP
	- 143 (IMAP - Dovecot) - TCP
	- 993 (IMAPS - Dovecot) - TCP
	- 995 (POP3S - Dovecot) - TCP
	- 4190 (ManageSieve - Dovecot) - TCP
- Git
	- 222 (SSH) - TCP

# Launch

- Setup : `chmod +x setup.sh && ./setup.sh`
- Start everything (no mailcow) : `./start.sh`

# Credits

Copyright © Ludovic Ortega, 2019

Contributor(s):

-Ortega Ludovic - ludovic.ortega@adminafk.fr
