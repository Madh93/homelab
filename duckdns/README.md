# Duck DNS

- [About](#about)
- [Requirements](#requirements)
- [Configuration](#configuration)
  * [Duck DNS account creation](#duck-dns-account-creation)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

We usually have a dynamic IP address at home. This means that in any moment our
public IP can change, either by restarting the router, or simply because the ISP
feels like it. To access our home network from anywhere we need to have a
mechanism that allows us to avoid having to constantly update our IP address.

DDNS (Dynamic DNS) is the solution to this problem: it allows us to send
information of our current public IP, and have a DNS record that is always
pointing to this IP.

The DDNS service that we are going to use is Duck DNS, a free and trusted
service that offers us to point a DNS to our public IP.

## Requirements

- [Duck DNS account](https://www.duckdns.org)

## Configuration

### Duck DNS account creation

First we need to register in Duck DNS. We will obtain an unique token to update
our domains. We can create until 5 custom domains, like `tastypeking.duckdns.org`.

After the domain creation we can verify this domain resolves our public IP:

```shell
user@host:~$ nslookup tastypeking.duckdns.org
Server:         1.1.1.1
Address:        1.1.1.1#53

Non-authoritative answer:
Name:   tastypeking.duckdns.org
Address: xxx.xxx.xxx.xxx
```

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
SUBDOMAINS="tastypeking"
TOKEN="supersecret"
```

And deploy:

    docker-compose up -d

## Useful links

- [Duck DNS](https://www.duckdns.org)
- [Duck DNS by LinuxServer.io](https://docs.linuxserver.io/images/docker-duckdns)

