# Authentik

- [About](#about)
- [Configuration](#configuration)
  * [Secret key setup](#secret-key-setup)
  * [Docker setup](#docker-setup)
  * [Superuser creation](#superuser-creation)
- [Useful links](#useful-links)

## About

Authentik is an open-source Identity Provider that emphasizes flexibility and versatility, with support for a wide set of protocols.

## Configuration

### Secret key setup

Before running Authentik it's necessary to define a [secret key](https://docs.goauthentik.io/docs/installation/docker-compose#preparation) that will must be populated in the `.env` file as `AUTHENTIK_SECRET_KEY` environment variable:

    openssl rand -base64 60

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="authentik"
AUTHENTIK_VERSION="2024.8.2"
POSTGRES_DATABASE="authentik"
POSTGRES_USER="authentik"
POSTGRES_PASSWORD="supersecret"
AUTHENTIK_SECRET_KEY="supersecret"
PUID=1000
PGID=1000

```

And deploy:

    docker-compose up -d

### Superuser creation

It's necessary to create a superuser account before starting Paperless-ngx for
the first time:

    docker exec -it paperless python3 /usr/src/paperless/src/manage.py createsuperuser


## Useful links

- [Authentik](https://goauthentik.io/)
