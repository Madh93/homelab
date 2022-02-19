# qBittorrent

- [About](#about)
- [Requirements](#requirements)
- [Configuration](#configuration)
  * [OpenVPN client setup](#openvpn-client-setup)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

qBittorrent is a fast and stable bittorrent client programmed in C++ / Qt that
uses libtorrent. If we want download torrents [anonymously](https://iknowwhatyoudownload.com/en/peer/) we will need a VPN too.

The `dperson/openvpn-client` docker container makes routing containers' traffic
through OpenVPN easy.

## Requirements

- VPN service (like [ProtonVPN](https://protonvpn.com))

## Configuration

### OpenVPN client setup

Assuming we have a VPN service. We need to create 2 files in
`$DOCKER_DATA/qbittorrent_vpn/config` directory.

First, the `vpn.auth` file where the OpenVPN credentials will be stored:

```shell
<USER>
<PASSWORD>
```

Later, the `vpn.conf` file where the OpenVPN config will be stored:

```shell
client
dev tun
proto tcp

# more configuration...
```

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DOWNLOADS_DATA="/downloads"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="qbittorrent.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
DNS=1.1.1.1
```

And deploy:

    docker-compose up -d

After deploying we can verify the qBittorrent container traffic goes through the
OpenVPN:

```shell
user@host:~$ curl ifconfig.me
xxx.xxx.xxx.xxx # Should be your public IP
user@host:~$ docker exec -it qbittorrent curl ifconfig.me
xxx.xxx.xxx.xxx # Should be the VPN provider IP
```

## Useful links

- [qBittorrent](https://www.qbittorrent.org/)
- [Linuxserver qBittorent Docs](https://docs.linuxserver.io/images/docker-qbittorrent)
- [OpenVPN](https://openvpn.net)
- [ProtonVPN](https://protonvpn.com)
- [OpenVPN Client docker container](https://github.com/dperson/openvpn-client)
- [Using openvpn-client with Docker](https://michaelheap.com/openvpn-docker-compose)
