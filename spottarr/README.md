# Spottarr

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
  * [NZBHydra 2 integration](#nzbhydra-2-integration)
- [Useful links](#useful-links)

## About

Spottarr is a modern Spotnet client and indexer. It reads Spotnet messages from
Usenet and exposes them through a Newznab-compatible API for applications such
as NZBHydra 2, Sonarr and Radarr.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="traefiknet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="spottarr"
PUID=1000
PGID=1000
TZ="Atlantic/Canary"
USENET__HOSTNAME="your.news.server.com"
USENET__USERNAME="your-username"
USENET__PASSWORD="supersecret"
USENET__PORT=563
USENET__USETLS=true
USENET__MAXCONNECTIONS=5
SPOTNET__IMPORTBATCHSIZE=10000
SPOTNET__RETENTIONDAYS=0
SPOTNET__IMPORTADULTCONTENT=false
SPOTNET__RETRIEVEAFTER="2026-01-01T00:00:00Z"
NEWZNAB__APIKEY="supersecret"
ADMIN__APIKEY="supersecret"
```

And deploy:

    docker-compose up -d

### NZBHydra 2 integration

When Spottarr is ready, add it to NZBHydra 2 as a **Generic Newznab** indexer
using the internal Docker URL:

    http://spottarr:8383/newznab

Use the value of `NEWZNAB__APIKEY` as the indexer API key. Both containers must
remain attached to the same external network. Sonarr and Radarr can continue
using NZBHydra 2 as their existing indexer source.

## Useful links

- [Spottarr](https://github.com/Spottarr/Spottarr)
- [Newznab API](https://newznab.readthedocs.io/en/latest/misc/api.html)
