# Immich

- [About](#about)
- [Configuration](#configuration)
  * [Machine Learning requirements](#machine-learning-requirements)
  * [OIDC setup](#oidc-setup)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Immich is an open source, high performance self-hosted backup solution for
videos and photos on your mobile phone.

## Configuration

### Machine Learning requirements

The Machine Learning (ML) service requires a CPU with AVX extensions.
Alternatively, you can build your own ML Docker image to build Tensorflow
without AVX extensions. More info [here](https://github.com/immich-app/immich/discussions/300).

### OIDC setup

Immich has built-in support for [OIDC authentication](https://immich.app/docs/administration/oauth), allowing users to log in via an external identity provider like [Pocket ID](https://pocket-id.org/). Before proceeding with the Docker setup, you must create a new OIDC client in your provider.

When creating the client, you will need to configure the next callback URLs:

- `https://<SUBDOMAIN>.<DOMAIN_NAME>/auth/login`
- `https://<SUBDOMAIN>.<DOMAIN_NAME>/user-settings`
- `app.immich:///oauth-callback`f

For example, based on the variables in the Docker setup, this would be `https://immich.domain.tld/auth/login`.

After creating the client, your OIDC provider will give you a **Client ID** and a **Client Secret**. These values, along with your provider's **Issuer URL**, are required to fill the values in Immich -> Administration -> Settings -> Authentication Settings -> OAuth.

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="immich"
TZ="Europe/Madrid"
IMMICH_VERSION="v1.143.1"
UPLOAD_LOCATION="/media/photos"
POSTGRES_DB="immich"
POSTGRES_USER="immich"
POSTGRES_PASSWORD="supersecret"
```

And deploy:

    docker-compose up -d

## Useful links

- [Immich](https://www.immich.app/)
- [Immich Docs](https://immich.app/docs/category/getting-started)
- [Machine Learning on CPUs without AVX](https://github.com/immich-app/immich/discussions/300)
- [Immich OIDC](https://immich.app/docs/administration/oauth/)
- [Pocket ID Immich Example](https://pocket-id.org/docs/client-examples/immich)
