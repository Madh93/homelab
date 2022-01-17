# AdGuard Home

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

AdGuard Home is a network-wide software for blocking ads & tracking. After you
set it up, it’ll cover ALL your home devices, and you don’t need any client-side
software for that. With the rise of Internet-Of-Things and connected devices, it
becomes more and more important to be able to control your whole network. We can
use it to:

- Ad blocking
- DNS rewrites

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="adguard.domain.tld"
```

And deploy:

    docker-compose up -d

## Useful links

- [AdGuard Home](https://adguard.com/en/adguard-home/overview.html)
- [AdGuard Home in Docker](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker)
- [Setting up AdGuard Home in Docker](https://linuxblog.xyz/posts/adguard/)
