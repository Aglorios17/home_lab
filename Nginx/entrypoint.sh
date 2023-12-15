#!/bin/sh

# Substitute environment variables in the template
envsubst '${PLEX_SUBDOMAIN} ${DOMAIN} ${PLEX_CONTAINER_NAME}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Start Nginx
nginx -g 'daemon off;'
