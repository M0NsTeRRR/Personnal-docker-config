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

# Configuration

- Personnal-website
	- `chmod 600 traefik/acme.json traefik/access.log traefik/traefik.log personnal-website/nginx/log/access.log personnal-website/nginx/log/error.log`
	- fill `backend/prod.env` (template : backend/prod.env.example)
- Wiki
	- fill `bookstack/bookstack.env` (template : bookstack/bookstack.env.example)
	- fill `bookstack/bookstack_db.env` (template : bookstack/bookstack_db.env.example)

# Launch

`docker-compose up -d`

# Credits

Copyright © Ludovic Ortega, 2019

Contributor(s):

-Ortega Ludovic - mastership@hotmail.fr