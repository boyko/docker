FROM smebberson/alpine-base

RUN apk --update --no-cache add certbot
ENV RENEW_AUTHENTICATOR=WEBROOT WEBROOT_AUTH_PATH=/etc/letsencrypt/webrootauth PRODUCTION=false FORCE_RENEW=false
COPY root /
EXPOSE 80
