# CyberChef

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

CyberChef is a simple, intuitive web app for carrying out all manner of "cyber"
operations within a web browser. These operations include simple encoding like
XOR and Base64, more complex encryption like AES, DES and Blowfish, creating
binary and hexdumps, compression and decompression of data, calculating hashes
and checksums, IPv6 and X.509 parsing, changing character encodings, and much
more.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="cyberchef"
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [CyberChef](https://github.com/gchq/CyberChef/)
- [CyberChef Docker](https://github.com/mpepping/docker-cyberchef)
