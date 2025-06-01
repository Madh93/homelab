# Hoarder

- [About](#about)
- [Requirements](#requirements)
- [Configuration](#configuration)
  * [Secret setup](#secret-setup)
  * [Docker setup](#docker-setup)
  * [Authelia setup](#authelia-setup)  
- [Useful links](#useful-links)

## About

Hoarder is an open-source collaborative bookmark manager to collect, organize and preserve webpages.

## Requirements

- [OpenAI API Key](https://platform.openai.com/api-keys)

## Configuration

### Secret setup

Before running hoarder it's necessary to define a two [secret keys](https://docs.hoarder.app/configuration) that will must be populated in the `.env` file as `MEILI_MASTER_KEY` and `NEXTAUTH_SECRET` environment variables:

    openssl rand -hex 64

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="hoarder"
MEILI_MASTER_KEY="supersecret"
NEXTAUTH_SECRET="supersecret"
OPENAI_API_KEY="supersecret"
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
    - domain: hoarder.domain.tld
      policy: bypass
      resources:
        - "^/api.*$"
```

## Useful links

- [Hoarder](https://hoarder.app/)
