FROM python:3.7-alpine as build

LABEL maintainer="Ludovic Ortega mastership@hotmail.fr"

# update package
RUN apk update

# install git
RUN apk add git

# download website project
RUN git clone https://github.com/M0NsTeRRR/website

# copy file to /app/
RUN mkdir -p /app/backend/ && mv website/backend/* /app/backend/

# install dependencies
RUN pip3 install -r ./app/backend/requirements.txt

FROM python:3.7-alpine

# update package
RUN apk update

# install gunicorn
RUN pip3 install gunicorn

# copy backend
COPY --from=build /app/backend/ /app/backend/

# copy python library
COPY --from=build  /usr/local/lib/python3.7/site-packages/ /usr/local/lib/python3.7/site-packages/

# set workdir
WORKDIR /app/backend/
