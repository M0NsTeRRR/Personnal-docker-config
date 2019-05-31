This is my personnal-docker-config, it will be depreciated when I will do my personnal-ansible-config.

# Requirement

- Docker compose with **Docker Engine >= 18.06.0+**

# Description

- Reverse proxy : Traefik
- Monitoring : *incoming*
- Personnal-website : homemade (https://ludovic-ortega.adminafk.fr)
	- server : Nginx
	- frontend : [Github repository link](https://github.com/M0NsTeRRR/Personnal-website/tree/master/frontend)
	- backend : [Github repository link](https://github.com/M0NsTeRRR/Personnal-website/tree/master/backend)
- Mailserver : *incoming*
- Wiki : Bookstack (https://wiki.adminafk.fr)
- VPN : *incoming*

# Configuration

- Reverse proxy:
	- `chmod 600 reverse-proxy/config/acme.json`
- Personnal-website
	- fill `personnal-website/backend/prod.env` (template : personnal-website/backend/prod.env.example)
- Wiki
	- fill `bookstack/config/bookstack.env` (template : bookstack/config/bookstack.env.example)
	- fill `bookstack/config/bookstack_db.env` (template : bookstack/config/bookstack_db.env.example)

# Launch

- Setup : `chmod +x setup.sh` and `./setup.sh`
Start everything : `chmod +x start.sh` and `./start.sh`

# Credits

Copyright © Ludovic Ortega, 2019

Contributor(s):

-Ortega Ludovic - mastership@hotmail.fr