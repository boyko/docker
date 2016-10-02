# Nginx + letsencrypt docker image

The container must be started with the following environmental variables:

- DOMAINS: a space delimited list of domains
- EMAIL: email address for letsencrypt

The follwing environmental variables are optional:

- DRY_RUN: if specified (any value) certbot will be run against the staging server

A cron job runs certbot renew on the first day of every month. Only certificates near expiry are renewed. The automatic renewal expects that the web server accepts connections on port 80 and that it is able to respond to requests to 

	/.well-known/acme-challenge

An example nginx location that does the job is:

	location /.well-known/acme-challenge {
	    alias /etc/letsencrypt/webrootauth/.well-known/acme-challenge;
	    add_header Content-Type application/jose+json;
	}
	