#!/usr/bin/with-contenv sh

if [[ "${RENEW_AUTHENTICATOR}" == "WEBROOT" ]]
then
    certbot renew --webroot --webroot-path ${WEBROOT_AUTH_PATH}
else
    # Standalone authenticator used in the start-up script (install_or_update_certificates.sh)
    certbot renew --pre-hook "${RENEW_PRE_HOOK}" --post-hook "${RENEW_POST_HOOK}"
fi
