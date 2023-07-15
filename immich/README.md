# Immich

- [About](#about)
- [Configuration](#configuration)
  * [Machine Learning requirements](#machine-learning-requirements)
  * [JWT setup](#jwt-setup)
  * [Typesense setup](#jwt-setup)
  * [Docker setup](#docker-setup)
  * [Authelia setup](#authelia-setup)
- [Useful links](#useful-links)

## About

Immich is an open source, high performance self-hosted backup solution for
videos and photos on your mobile phone.

## Configuration

### Machine Learning requirements

The Machine Learning (ML) service requires a CPU with AVX extensions.
Alternatively, you can build your own ML Docker image to build Tensorflow
without AVX extensions. More info [here](https://github.com/immich-app/immich/discussions/300).

### JWT setup

Before running Immich it's necessary to define a [JWT secret](https://immich.app/docs/installation/recommended-installation#step-2---populate-the-env-file-with-custom-values) that will must be populated in the `.env` file as `JWT_SECRET` environment variable:

    openssl rand -base64 128

### JWT setup

Before running Immich it's necessary to define a [Typesense API Key](https://immich.app/docs/installation/recommended-installation#step-2---populate-the-env-file-with-custom-values) that will must be populated in the `.env` file as `TYPESENSE_API_KEY` environment variable:

    openssl rand -base64 128

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="immich.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
IMMICH_VERSION="v1.66.1"
UPLOAD_LOCATION="/media/photos"
JWT_SECRET="supersecret" 
TYPESENSE_API_KEY="supersecret"
POSTGRES_DB="immich"
POSTGRES_USER="immich"
POSTGRES_PASSWORD="supersecret"
```

And deploy:

    docker-compose up -d

### Authelia setup

It's necessary to bypass `/api` if you want to use the mobile app to upload your
photos.

Add the next rule to the Authelia `configuration.yml`:

```yml
access_control:
  default_policy: deny
  rules:
    - domain: immich.domain.tld
      policy: bypass
      resources:
        - "^/api.*$"
```

## Useful links

- [Immich](https://www.immich.app/)
- [Immich Docs](https://immich.app/docs/category/getting-started)
- [Machine Learning on CPUs without AVX](https://github.com/immich-app/immich/discussions/300)
