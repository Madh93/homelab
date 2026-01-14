# Pocket ID

- [About](#about)
- [Configuration](#configuration)
  * [Encryption key setup](#encryption-key-setup)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Pocket ID is a simple OIDC provider that allows users to authenticate with their passkeys to your services.

## Configuration

### Encryption key setup

Before running Pocket ID it's necessary to define an encryption key that will must be populated in the `.env` file as `ENCRYPTION_KEY` environment variable:

    openssl rand -base64 32

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="pocketid"
ENCRYPTION_KEY="supersecret"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Pocket ID](https://pocket-id.org/)
