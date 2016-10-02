FROM amarov/alpine-letsconfd

ENV CONFD_BACKEND=env
RUN apk --update --no-cache add nginx
COPY root /

EXPOSE 80 443
