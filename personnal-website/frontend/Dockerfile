FROM node:12.7-alpine as build

LABEL maintainer="Ludovic Ortega mastership@hotmail.fr"

# update package
RUN apk update

# install git
RUN apk add git

# download website project
RUN git clone https://github.com/M0NsTeRRR/website

# copy file to /app/
RUN mkdir -p /app/frontend/ && mv website/frontend/* /app/frontend/

# set workdir
WORKDIR /app/frontend/

# install dependencies
RUN npm install

# build frontend
RUN npm run-script build

# create static directory
RUN mkdir -p /opt/services/frontend/static/

# copy dist files in static directory
RUN mv ./dist/* /opt/services/frontend/static/