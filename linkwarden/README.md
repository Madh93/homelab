# Linkwarden

- [About](#about)
- [Configuration](#configuration)
  * [Secret setup](#secret-setup)
  * [Docker setup](#docker-setup)
  * [Authelia setup](#authelia-setup)  
- [Useful links](#useful-links)

## About

Linkwarden is an open-source collaborative bookmark manager to collect, organize and preserve webpages.

## Configuration

### Secret setup

Before running Linkwarden it's necessary to define a [secret key](https://docs.linkwarden.app/self-hosting/installation#3-configure-the-environment-variables) that will must be populated in the `.env` file as `NEXTAUTH_SECRET` environment variable:

    openssl rand -hex 64

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="linkwarden.domain.tld"
POSTGRES_DATABASE="linkwarden"
POSTGRES_USER="linkwarden"
POSTGRES_PASSWORD="supersecret"
NEXTAUTH_SECRET="supersecret"
PUID=1000
PGID=1000
```

And deploy:

    docker-compose up -d

### Authelia setup

It's necessary to bypass `/api` if you want to use the extension from mobile devices.

Add the next rule to the Authelia `configuration.yml`:

```yml
access_control:
  default_policy: deny
  rules:
    - domain: linkwarden.domain.tld
      policy: bypass
      resources:
        - "^/api.*$"
```

## Useful links

- [Linkwarden](https://linkwarden.app/)
