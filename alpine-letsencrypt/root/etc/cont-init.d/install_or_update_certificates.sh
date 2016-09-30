#! /usr/bin/with-contenv sh

# The domains environment variable must be specified

if [ -z "${DOMAINS}" ]
then
    exit 1
fi

if [[ "${RENEW_AUTHENTICATOR}" != "WEBROOT" ]]
then
    if [ -z "${RENEW_PRE_HOOK}" ] || [ -z "${RENEW_POST_HOOK}" ]
    then
        # If we are not using the webroot authenticator then we must specify pre and post hooks for the standalone
        # authenticator
        exit 2
    fi
fi

if [ -z "${WEBROOT_AUTH_PATH}" ]
then
    export WEBROOT_AUTH_PATH=/etc/letsencrypt/webrootauth
fi

mkdir -p ${WEBROOT_AUTH_PATH}


set -- ${DOMAINS}
FIRST_DOMAIN=$1

CERT_PATH=/etc/letsencrypt/live/${FIRST_DOMAIN}

for domain in ${DOMAINS}
do
    DOMAIN_OPTS="-d $domain ${DOMAIN_OPTS}"
done


SERVER_OPTS=""

if [ -z "${DRY_RUN}" ]
then
    echo "==> Setting dry run options"
    SERVER_OPTS="--test-cert --server https://acme-staging.api.letsencrypt.org/directory"
fi


CERTBOT_OPTS="--standalone --standalone-supported-challenges http-01 ${DOMAIN_OPTS} ${SERVER_OPTS} --email ${EMAIL} --agree-tos"

echo "==> Launching certbot with options:"
echo ${CERTBOT_OPTS}

if [ ! -z "${CERT_PATH}" ]
then
    mkdir -p ${WEBROOT_AUTH_PATH}
    certbot certonly ${CERTBOT_OPTS}
else
    certbot renew ${CERTBOT_OPTS}
fi
