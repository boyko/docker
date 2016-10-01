#! /usr/bin/with-contenv sh

###################
# Settings checks #
###################

if [ -z "${DOMAINS}" ]
then
    echo "ERROR: the DOMAINS environmental variable is required!"
    exit 1
fi

if [ -z "${EMAIL}" ]
then
    echo "ERROR: the EMAIL environmental variable is required!"
    exit 2
fi


if [[ "${RENEW_AUTHENTICATOR}" == "standalone" ]]
then
    if [ -z "${RENEW_PRE_HOOK}" ] || [ -z "${RENEW_POST_HOOK}" ]
    then
        echo "Using the standalone authenticator without specifying RENEW_PRE_HOOK or RENEW_POST_HOOK"
        exit 3
    fi
fi


# Create the letsencrypt path if it does not exist and set user

mkdir -p ${WEBROOT_AUTH_PATH}

######################################
# Options for the letsencrypt client #
######################################


for domain in ${DOMAINS}
do
    DOMAIN_OPTS="-d $domain ${DOMAIN_OPTS}"
done


SERVER_OPTS=""

if [ "${PRODUCTION}" = false ]
then
    echo "==> Using staging server"
    SERVER_OPTS="--test-cert --server https://acme-staging.api.letsencrypt.org/directory"
fi

FORCE_RENEW_OPTS=""

if [ "${FORCE_RENEW}" = true ]
then
    FORCE_RENEW_OPTS="--force-renew"
fi


CERTBOT_OPTS="--standalone --standalone-supported-challenges http-01 ${DOMAIN_OPTS} ${SERVER_OPTS} --email ${EMAIL} --agree-tos"

set -- ${DOMAINS}
FIRST_DOMAIN=$1

CERT_PATH=/etc/letsencrypt/live/${FIRST_DOMAIN}

if [ ! -z "${CERT_PATH}" ]
then
    echo "==> Launching certbot with options:"
    echo ${CERTBOT_OPTS}
    certbot certonly ${CERTBOT_OPTS}
else
    echo "==> Renewing certificates with options:"
    echo ${CERTBOT_OPTS}
    certbot renew ${CERTBOT_OPTS} ${FORCE_RENEW_OPTS}
fi
