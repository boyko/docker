#!/usr/bin/with-contenv sh

echo "==> Running confd with backend ${CONFD_BACKEND}"
confd --onetime -backend ${CONFD_BACKEND} --log-level=debug
