# Paperless-ngx

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
  * [Superuser creation](#superuser-creation)
  * [Authelia setup](#authelia-setup)  
- [Useful links](#useful-links)

## About

Paperless-ngx is a community-supported open-source document management system
that transforms your physical documents into a searchable online archive so you
can keep, well, less paper.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DATA_LOCATION="/media/files"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="paperless.domain.tld"
POSTGRES_DATABASE="paperless"
POSTGRES_USER="paperless"
POSTGRES_PASSWORD="supersecret"
PAPERLESS_SECRET_KEY="supersecret"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

### Superuser creation

It's necessary to create a superuser account before starting Paperless-ngx for
the first time:

    docker exec -it paperless python3 /usr/src/paperless/src/manage.py createsuperuser

### Authelia setup

It's necessary to bypass `/api` if you want to use the mobile app to upload your
documents.

Add the next rule to the Authelia `configuration.yml`:

```yml
access_control:
  default_policy: deny
  rules:
    - domain: paperless.domain.tld
      policy: bypass
      resources:
        - "^/api.*$"
```

## Useful links

- [Paperless-ngx](https://docs.paperless-ngx.com/)
