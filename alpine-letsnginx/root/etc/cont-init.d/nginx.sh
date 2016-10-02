#!/usr/bin/with-contenv sh

addgroup nginx && adduser nginx -G nginx
mkdir -p /run/nginx/
