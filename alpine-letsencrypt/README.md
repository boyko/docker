# Nginx + letsencrypt docker image

The container must be started with the following environmental variables:

- DOMAINS: a space delimited list of domains
- EMAIL: email address for letsencrypt

The follwing environmental variables are optional:

- PRODUCTION: if false (the default) certbot will run agains the staging server.
- FORCE_RENEW: if true (default is false) sets the --force-renew flag in `cerbot renew`

A cron job runs certbot renew every month. Only certificates near expiry are renewed. The automatic renewal expects that the web server accepts connections on port 80 and that it is able to respond to requests to 

	/.well-known/acme-challenge

An example nginx location that does the job is:

	location /.well-known/acme-challenge {
	    alias /etc/letsencrypt/webrootauth/.well-known/acme-challenge;
	    add_header Content-Type application/jose+json;
	}
