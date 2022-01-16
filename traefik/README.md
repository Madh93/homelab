# Traefik

- [About](#about)
- [Requirements](#requirements)
- [Configuration](#configuration)
  * [DNS setup](#dns-setup)
  * [Lets Encrypt](#lets-encrypt)
  * [Dashboard auth](#dashboard-auth)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

To expose our services to the internet without having to open a different port
for each of them, it is necessary to use a reverse proxy. A reverse proxy allows
us to redirect all those external requests to the service specifically based on
the hostname. That means we just have to open ports 80 and 443 and we don't have
to remember any port. More info
[here](https://www.smarthomebeginner.com/traefik-reverse-proxy-tutorial-for-docker/#Reverse_Proxy_Primer).

Traefik is a modern HTTP reverse proxy and load balancer that makes deploying
microservices easy. Traefik integrates with your existing infrastructure
components (Docker, Swarm mode, Kubernetes, Marathon, Consul, Etcd, Rancher,
Amazon ECS, ...) and configures itself automatically and dynamically.

## Requirements

- [A domain name](https://www.namecheap.com/)
- [DigitalOcean account](https://www.digitalocean.com/)

## Configuration

### DNS setup

It's necessary to register a domain name. In my case I use
[Namecheap](https://www.namecheap.com/) but to manage the DNS records I use
DigitalOcean instead so it's necessary to point to DigitalOcean the nameservers
from Namecheap. More info [here](https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars).

### Lets Encrypt

Traefik can use an ACME provider (like Let's Encrypt) for automatic certificate
generation. When we get a certificate from Let’s Encrypt, theirs servers validate that we
control the domain names in that certificate using “challenges,” as defined by
the ACME standard. This validation is handled automatically by our ACME client
(Traefik). The more important challenges are:

- **HTTP:** Lets' Encrypt validates through ports 80/443 (they need to be open).
  Nice explanation
  [here](https://github.com/DoTheEvo/Traefik-v2-examples/#4-lets-encrypt-certificate-http-challenge).
- **DNS:** Lets' Encrypt validates through a DNS TXT record (no port need to be
  open). Nice explanation
  [here](https://github.com/DoTheEvo/Traefik-v2-examples/#5-lets-encrypt-certificate-dns-challenge-on-cloudflare).

More info about Let's Encrypt challenge types [here](https://letsencrypt.org/docs/challenge-types/).

Traefik supports DigitalOcean as DNS provider to automate the Let's Encrypt DNS
verification. The necessary configuration is the next:

```yaml
environment:
  - DO_AUTH_TOKEN=$DO_AUTH_TOKEN
command:
  - "--certificatesResolvers.letsencrypt.acme.email=$LETS_ENCRYPT_EMAIL"
  - "--certificatesResolvers.letsencrypt.acme.storage=acme.json"
  - "--certificatesresolvers.letsencrypt.acme.dnschallenge=true"
  - "--certificatesresolvers.letsencrypt.acme.dnschallenge.provider=digitalocean"
```

Traefik will automatically try to renew the certificate when less than 30 days
is remaining.

### Dashboard auth

The Traefik API built-in dashboard does not have authentication by default. This
can be solved using Traefik itself using the BasicAuth middleware.

To generate the password file:

    htpasswd -c -b $DOCKER_DATA/traefik/credentials <USERNAME> <PASSWORD>

And add the next configuration:

```yaml
volumes:
  - $DOCKER_DATA/traefik/credentials:/credentials:ro
labels:
  - "traefik.http.routers.traefik.middlewares=dashboard-auth"
  - "traefik.http.middlewares.dashboard-auth.basicauth.usersfile=/credentials"
```

### Docker setup

We create an empty `acme.json` file for Let's Encrypt certificates:

    touch $DOCKER_DATA/traefik/acme.json && chmod 600 $DOCKER_DATA/traefik/acme.json

We create our Traefik network:

    docker create network badassnet

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="traefik.domain.tld"
LETS_ENCRYPT_EMAIL="alice@example.org"
DO_AUTH_TOKEN="supersecret"
```

And deploy:

    docker-compose up -d

## Useful links

- [Namecheap](https://www.namecheap.com/)
- [DigitalOcean](https://www.digitalocean.com/)
- [How to point to DigitalOcean Nameservers from Namecheap](https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars)
- [Traefik](https://doc.traefik.io/traefik/)
- [Traefik Tutorial](https://www.smarthomebeginner.com/traefik-2-docker-tutorial/)
- [Traefik Quick Guide By Examples](https://github.com/DoTheEvo/Traefik-v2-examples/)
- [Traefik Let's Encrypt Docs](https://doc.traefik.io/traefik/https/acme/)
- [Let's Encrypt Challenge Types](https://letsencrypt.org/docs/challenge-types/)