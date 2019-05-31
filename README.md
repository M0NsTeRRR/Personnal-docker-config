This is my personnal-docker-config, it will be depreciated when I will do my personnal-ansible-config.

# Requirement

- Docker compose with **Docker Engine >= 18.06.0+**

# Description

- Reverse proxy : Traefik
- Logrotate : *incoming*
- Fail2ban : *incoming*
- Monitoring : *incoming*
- Personnal-website
	- server : Nginx
	- frontend : [link](https://github.com/M0NsTeRRR/Personnal-website/tree/master/frontend)
	- backend : [link](https://github.com/M0NsTeRRR/Personnal-website/tree/master/backend)
- Mailserver : *incoming*
- Wiki : *incoming*

# Configuration

- personnal-website
	- `chmod 600 traefik/acme.json traefik/access.log traefik/traefik.log personnal-website/nginx/log/access.log personnal-website/nginx/log/error.log`
	- fill backend/prod.env

# Launch

`docker-compose up -d`

# Credits

Copyright © Ludovic Ortega, 2019

Contributor(s):

-Ortega Ludovic - mastership@hotmail.fr