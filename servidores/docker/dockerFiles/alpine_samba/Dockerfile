FROM alpine:latest
MAINTAINER Candido Tominaga <candido1212@gmail.com>
LABEL Description="Lightweight Samba Server docker container installed on Alpine Linux"


# update system (Alpine Linux)
RUN apk update && apk upgrade

# Now, install samba server
RUN apk add --no-cache samba samba-common-tools bash

# Create folder for share
RUN mkdir -p /web /lixeira /logs

COPY smb.conf /etc/samba/

# volume mappings
VOLUME /web /lixeira /logs

# Expose ports
EXPOSE 137 138 139 445
