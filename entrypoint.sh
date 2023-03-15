#!/bin/bash
CERT=/ssl/cert.pem
KEY=/ssl/key.pem
if [ ! -f "$CERT" ] || [ ! -f "$KEY" ]; then
    openssl req -subj "/CN=${DOMAIN}" -addext "subjectAltName = DNS:${DOMAIN}" -x509 -newkey rsa:4096 -nodes -keyout key.pem -out cert.pem -days 365
    cp /ssl/cert.pem /ssl/cert.crt
fi
export DOLLAR='$'
envsubst < /etc/nginx/conf.d/virtual-site.template > /etc/nginx/conf.d/default.conf
exec nginx -g 'daemon off;'