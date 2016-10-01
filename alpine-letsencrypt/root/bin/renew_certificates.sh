#!/usr/bin/with-contenv sh


if [ "${FORCE_RENEW}" = true ]
then
    echo "==> Using --force-renew"
    RENEW_OPTS="--force-renew"
fi

if [[ "${RENEW_AUTHENTICATOR}" == "WEBROOT" ]]
then
    certbot renew --webroot --webroot-path ${WEBROOT_AUTH_PATH} ${RENEW_OPTS}
else
    # Standalone authenticator used in the start-up script (install_or_update_certificates.sh)
    certbot renew --pre-hook "${RENEW_PRE_HOOK}" --post-hook "${RENEW_POST_HOOK}" ${RENEW_OPTS}
fi
