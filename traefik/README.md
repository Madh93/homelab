# Traefik

- [About](#about)
- [Requirements](#requirements)
- [Configuration](#configuration)
  * [DNS setup](#dns-setup)
  * [Lets Encrypt](#lets-encrypt)
  * [Dashboard auth](#dashboard-auth)
  * [IP Whitelist](#ip-whitelist)
  * [Log rotating](#log-rotating)
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
- [Cloudflare account](https://www.cloudflare.com/)

## Configuration

### DNS setup

It's necessary to register a domain name. In my case I use
[Namecheap](https://www.namecheap.com/) but to manage the DNS records I use
Cloudflare instead so it's necessary to point to Cloudflare the nameservers
from Namecheap. More info [here](https://www.namecheap.com/support/knowledgebase/article.aspx/9607/2210/how-to-set-up-dns-records-for-your-domain-in-cloudflare-account/).

### Lets Encrypt

Traefik can use an ACME provider (like Let's Encrypt) for automatic certificate
generation. When we get a certificate from Let’s Encrypt, theirs servers validate that we
control the domain names in that certificate using "challenges", as defined by
the ACME standard. This validation is handled automatically by our ACME client
(Traefik). The more important challenges are:

- **HTTP:** Lets' Encrypt validates through ports 80/443 (they need to be open).
  Nice explanation
  [here](https://github.com/DoTheEvo/Traefik-v2-examples/#4-lets-encrypt-certificate-http-challenge).
- **DNS:** Lets' Encrypt validates through a DNS TXT record (no port need to be
  open). Nice explanation
  [here](https://github.com/DoTheEvo/Traefik-v2-examples/#5-lets-encrypt-certificate-dns-challenge-on-cloudflare).

More info about Let's Encrypt challenge types [here](https://letsencrypt.org/docs/challenge-types/).

Traefik supports Cloudflare as DNS provider to automate the Let's Encrypt DNS
verification. We only need to create an [API Token](https://developers.cloudflare.com/api/tokens/create/). The necessary configuration is the next:

```yaml
environment:
  - CF_DNS_API_TOKEN=$CF_DNS_API_TOKEN
command:
  - "--certificatesResolvers.letsencrypt.acme.email=$LETS_ENCRYPT_EMAIL"
  - "--certificatesResolvers.letsencrypt.acme.storage=acme.json"
  - "--certificatesresolvers.letsencrypt.acme.dnschallenge=true"
  - "--certificatesresolvers.letsencrypt.acme.dnschallenge.provider=cloudflare"
```

Traefik will automatically try to renew the certificate when less than 30 days
is remaining.

### Dashboard auth

The Traefik API built-in dashboard does not have authentication by default. This
can be solved with Traefik itself using the [BasicAuth middleware](https://doc.traefik.io/traefik/middlewares/http/basicauth/).

To generate the password file:

    mkdir -p $DOCKER_DATA/traefik/credentials
    htpasswd -c -b $DOCKER_DATA/traefik/credentials/traefik <USERNAME> <PASSWORD>

And add the next configuration:

```yaml
volumes:
  - $DOCKER_DATA/traefik/credentials:/credentials:ro
labels:
  - "traefik.http.routers.traefik.middlewares=dashboard-auth"
  - "traefik.http.middlewares.dashboard-auth.basicauth.usersfile=/credentials/traefik"
```

### IP Whitelist

We can limit the Traefik API built-in dashboard (and others services too) to
specific IPs. This can be solved with Traefik itself using the [IPWhiteList middleware](https://doc.traefik.io/traefik/middlewares/http/ipwhitelist/).

And add the next configuration:

```yaml
labels:
  - "traefik.http.routers.traefik.middlewares=lan-only"
  - "traefik.http.middlewares.lan-only.ipwhitelist.sourceRange=192.168.0.0/24"
```

### Log rotating

Traefik access logs are written to the standard output by default. To use
fail2ban to ban malicious IP addresses we need to write the logs into a log
file.

Add the next configuration:

```yaml
volumes:
  - /var/log/traefik:/logs
command:
  - "--accessLog=true"
  - "--accessLog.filePath=logs/traefik.log"
  - "--accessLog.bufferingSize=100"
```

We can use [logrotate](https://linux.die.net/man/8/logrotate) to allow automatic
rotation, compression and removal of older log files.

Create the next file:

    touch /etc/logrotate.d/traefik

And add the next configuration:

```txt
/var/log/traefik/*.log {
  daily
  size 1M
  rotate 7
  missingok
  notifempty
  postrotate
    docker kill --signal="USR1" traefik
  endscript
}
```

### Docker setup

We create an empty `acme.json` file for Let's Encrypt certificates:

    touch $DOCKER_DATA/traefik/acme.json && chmod 600 $DOCKER_DATA/traefik/acme.json

We create our Traefik network:

    docker network create badassnet

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="traefik.domain.tld"
LETS_ENCRYPT_EMAIL="alice@example.org"
CF_DNS_API_TOKEN="supersecret"
HOME_SUBNET="192.168.0.0/24"
```

And deploy:

    docker-compose up -d

## Useful links

- [Namecheap](https://www.namecheap.com/)
- [Cloudflare](https://www.cloudflare.com/)
- [How to point to Cloudflare Nameservers from Namecheap](https://www.namecheap.com/support/knowledgebase/article.aspx/9607/2210/how-to-set-up-dns-records-for-your-domain-in-cloudflare-account/)
- [Creating Cloudflare API tokens](https://developers.cloudflare.com/api/tokens/create/)
- [Traefik](https://doc.traefik.io/traefik/)
- [Traefik Tutorial](https://www.smarthomebeginner.com/traefik-2-docker-tutorial/)
- [Traefik Quick Guide By Examples](https://github.com/DoTheEvo/Traefik-v2-examples/)
- [Traefik HTTP Middlewares: BasicAuth ](https://doc.traefik.io/traefik/middlewares/http/basicauth/)
- [Traefik HTTP Middlewares: IpWhitelist ](https://doc.traefik.io/traefik/middlewares/http/ipwhitelist/)
- [Traefik Let's Encrypt Docs](https://doc.traefik.io/traefik/https/acme/)
- [Let's Encrypt Challenge Types](https://letsencrypt.org/docs/challenge-types/)
- [Rotating Traefik logs with logrotate](https://geekland.eu/configurar-la-rotacion-de-logs-en-traefik-con-logrotate/)
