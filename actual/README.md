# Actual Budget

- [About](#about)
- [Configuration](#configuration)
  * [OIDC setup](#oidc-setup)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Actual Budget is a super fast and privacy-focused app for managing your finances. At its heart is the well proven and much loved Envelope Budgeting methodology.

## Configuration

### OIDC setup

Actual Budget has built-in support for [OIDC authentication](https://actualbudget.org/docs/config/oauth-auth), allowing users to log in via an external identity provider like [Pocket ID](https://pocket-id.org/). Before proceeding with the Docker setup, you must create a new OIDC client in your provider.

When creating the client, you will need to configure the following callback URL:

- **Callback URL:** `https://<SUBDOMAIN>.<DOMAIN_NAME>/openid/callback`

For example, based on the variables in the Docker setup, this would be `https://actual.domain.tld/openid/callback`.

After creating the client, your OIDC provider will give you a **Client ID**, a **Client Secret**, and an **OIDC Discovery URL**. These values, are required for the `.env` file in the next step.

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="actual"
ACTUAL_OPENID_SERVER_HOSTNAME="https://actual.domain.tld"
ACTUAL_OPENID_DISCOVERY_URL="https://pocketid.domain.tld"
ACTUAL_OPENID_CLIENT_ID="createdwithpocketid"
ACTUAL_OPENID_CLIENT_SECRET="createdwithpocketid"
ACTUAL_OPENID_ENFORCE="true"
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Actual Budget](https://actualbudget.org/)
