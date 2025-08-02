# Karakeep

- [About](#about)
- [Requirements](#requirements)
- [Configuration](#configuration)
  * [Secret setup](#secret-setup)
  * [OIDC setup](#oidc-setup)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Karakeep (previously Hoarder) is an open-source collaborative bookmark manager to collect, organize and preserve webpages.

## Requirements

- [OpenAI API Key](https://platform.openai.com/api-keys) or other OpenAI-compatible provider (more info [here](https://docs.karakeep.app/Guides/different-ai-providers))

## Configuration

### Secret setup

Before running karakeep it's necessary to define a two [secret keys](https://docs.karakeep.app/configuration) that will must be populated in the `.env` file as `MEILI_MASTER_KEY` and `NEXTAUTH_SECRET` environment variables:

    openssl rand -hex 64

### OIDC setup

Planka has built-in support for [OIDC authentication](https://docs.karakeep.app/configuration/#authentication--signup), allowing users to log in via an external identity provider like [Pocket ID](https://pocket-id.org/). Before proceeding with the Docker setup, you must create a new OIDC client in your provider.

When creating the client, you will need to configure the following parameter:

- **Callback URL:** `https://<SUBDOMAIN>.<DOMAIN_NAME>/api/auth/callback/custom`

For example, based on the variables in the Docker setup, this would be `https://karakeep.domain.tld/api/auth/callback/custom`.

After creating the client, your OIDC provider will give you a **Client ID** and a **Client Secret**. These values, along with your provider's URL, are required for the `.env` file in the next step.

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
OAUTH_PROVIDER_NAME="Pocket ID"
OAUTH_WELLKNOWN_URL="https://pocketid.domain.tld/.well-known/openid-configuration"
OAUTH_CLIENT_ID="supersecret"
OAUTH_CLIENT_SECRET="supersecret"
PUID=1000
PGID=1000
```

And deploy:

    docker-compose up -d

## Useful links

- [Karakeep](https://karakeep.app/)
- [Karakeep OIDC](https://docs.karakeep.app/configuration/#authentication--signup)
- [Pocket ID Karakeep Example](https://pocket-id.org/docs/client-examples/karakeep)
