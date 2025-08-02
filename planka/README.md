# Planka

- [About](#about)
- [Configuration](#configuration)
  * [Secret setup](#secret-setup)
  * [OIDC setup](#oidc-setup)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Planka is a flexible and customizable project management tool that helps teams collaborate and organize their tasks and projects.

## Configuration

### Secret setup

Before running Planka it's necessary to define a [secret key](https://docs.planka.cloud/docs/installl-planka/Docker%20Compose#docker-compose) that will must be populated in the `.env` file as `SECRET_KEY` environment variable:

    openssl rand -hex 64

### OIDC setup

Planka has built-in support for OIDC authentication, allowing users to log in via an external identity provider like [Pocket ID](https://pocket-id.org/). Before proceeding with the Docker setup, you must create a new OIDC client in your provider.

When creating the client, you will need to configure the following parameter:

- **Callback URL:** `https://<SUBDOMAIN>.<DOMAIN_NAME>/oidc-callback`

For example, based on the variables in the Docker setup, this would be `https://planka.domain.tld/oidc-callback`.

After creating the client, your OIDC provider will give you a **Client ID** and a **Client Secret**. These values, along with your provider's URL, are required for the `.env` file in the next step.

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="planka"
POSTGRES_DATABASE="planka"
POSTGRES_USER="planka"
POSTGRES_PASSWORD="supersecret"
SECRET_KEY="supersecret"
OIDC_ISSUER="https://pocketid.domain.tld"
OIDC_CLIENT_ID="createdwithpocketid"
OIDC_CLIENT_SECRET="createdwithpocketid"
PUID=1000
PGID=1000
```

And deploy:

    docker-compose up -d

## Useful links

- [Planka](https://planka.app/)
- [Planka OIDC](https://docs.planka.cloud/docs/configuration/oidc)
- [Pocket ID Planka Example](https://pocket-id.org/docs/client-examples/planka)
