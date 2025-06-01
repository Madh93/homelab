# Karakeep

- [About](#about)
- [Requirements](#requirements)
- [Configuration](#configuration)
  * [Secret setup](#secret-setup)
  * [Docker setup](#docker-setup)
  * [Authelia setup](#authelia-setup)  
- [Useful links](#useful-links)

## About

Karakeep (previously Hoarder) is an open-source collaborative bookmark manager to collect, organize and preserve webpages.

## Requirements

- [OpenAI API Key](https://platform.openai.com/api-keys) or other OpenAI-compatible provider (more info [here](https://docs.karakeep.app/Guides/different-ai-providers))

## Configuration

### Secret setup

Before running karakeep it's necessary to define a two [secret keys](https://docs.karakeep.app/configuration) that will must be populated in the `.env` file as `MEILI_MASTER_KEY` and `NEXTAUTH_SECRET` environment variables:

    openssl rand -hex 64

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="karakeep"
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
    - domain: karakeep.domain.tld
      policy: bypass
      resources:
        - "^/api.*$"
```

## Useful links

- [Karakeep](https://karakeep.app/)
