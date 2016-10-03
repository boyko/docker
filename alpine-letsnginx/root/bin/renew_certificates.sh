#!/usr/bin/with-contenv sh

_renew_certificates.sh
s6-svc -h /etc/services.d/nginx
