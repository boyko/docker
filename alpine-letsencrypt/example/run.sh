#!/usr/bin/env sh

# Substitute your domains below
docker run -p 80:80 -p 443:443 -e DOMAINS="b98320e7.ngrok.io" -e EMAIL=test@test.com amarov/alpine-letsencrypt