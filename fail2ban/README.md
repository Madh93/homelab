# Fail2ban

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Fail2Ban scans log files like `/var/log/auth.log` and bans IP addresses
conducting too many failed login attempts.

It does this by updating system firewall rules to reject new connections from
those IP addresses, for a configurable amount of time. Fail2Ban comes
out-of-the-box ready to read many standard log files, such as those for sshd and
Apache, and is easily configured to read any log file of your choosing, for any
error you wish.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Fail2ban](https://www.fail2ban.org/)
- [Fail2ban Traefik example](https://github.com/crazy-max/docker-fail2ban/tree/master/examples/jails/traefik)
- [Using Fail2ban with Traefik](https://geekland.eu/usar-fail2ban-con-traefik-para-proteger-servicios-que-corren-en-docker/)
