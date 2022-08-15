# SABnzbd

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
  * [Authelia setup](#authelia-setup)
- [Useful links](#useful-links)

## About

SABnzbd is an Open Source Binary Newsreader written in Python.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DOWNLOADS_DATA="/downloads"
INCOMPLETE_DOWNLOADS_DATA="/incomplete"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="sabnzbd.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

### Authelia setup

It's necessary to bypass `/api` if you want to use a third party application as [nzb360](https://nzb360.com).

Add the next rule to the Authelia `configuration.yml`:

```yml
access_control:
  default_policy: deny
  rules:
    - domain: sabnzbd.domain.tld
      policy: bypass
      resources:
        - '^/api.*$'
```

## Useful links

- [SABnzbd](https://sabnzbd.org/)
- [Linuxserver SABnzbd Docs](https://docs.linuxserver.io/images/docker-sabnzbd)
