# Traefik

- [About](#about)
- [Requirements](#requirements)
- [Configuration](#configuration)
  * [DNS setup](#dns-setup)
  * [Lets Encrypt](#lets-encrypt)
  * [Dashboard auth](#dashboard-auth)
  * [OIDC Authentication](#oidc-authentication)
  * [Handling Origin IPs from Cloudflare](#handling-origin-ips-from-cloudflare)
  * [IP Whitelist](#ip-whitelist)
  * [Log rotating](#log-rotating)
  * [Error pages](#error-pages)
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

### OIDC Authentication

For a more robust and centralized Single Sign-On (SSO) experience, we can delegate authentication to an OIDC identity provider (e.g., [Pocket ID](https://pocket-id.org/)) using the [traefik-oidc-auth](https://traefik-oidc-auth.sevensolutions.cc/) plugin.

The plugin is enabled via static configuration arguments in the `command` section:

```yaml
command:
  # OIDC Authentication Plugin
  - "--experimental.plugins.traefik-oidc-auth.modulename=github.com/sevensolutions/traefik-oidc-auth"
  - "--experimental.plugins.traefik-oidc-auth.version=v0.13.0"
```

The middleware itself and the required callback router are configured via labels on the Traefik container. This creates a single, reusable `oidc-auth` middleware.

```yaml
labels:
  # OIDC Authentication Middleware Definition
  - "traefik.http.middlewares.oidc-auth.plugin.traefik-oidc-auth.secret=${OIDC_SECRET}"
  - "traefik.http.middlewares.oidc-auth.plugin.traefik-oidc-auth.provider.url=https://${OIDC_SUBDOMAIN}.${DOMAIN_NAME}/"
  - "traefik.http.middlewares.oidc-auth.plugin.traefik-oidc-auth.provider.clientId=${OIDC_CLIENT_ID}"
  - "traefik.http.middlewares.oidc-auth.plugin.traefik-oidc-auth.provider.clientSecret=${OIDC_CLIENT_SECRET}"
  - "traefik.http.middlewares.oidc-auth.plugin.traefik-oidc-auth.scopes=${OIDC_SCOPES}"
  # OIDC Callback Router (handles redirect from the OIDC provider)
  - "traefik.http.routers.traefik-callback.entrypoints=websecure"
  - "traefik.http.routers.traefik-callback.rule=Host(`$SUBDOMAIN.$DOMAIN_NAME`) && (PathPrefix(`/oidc/callback`) || PathPrefix(`/logout`))"
  - "traefik.http.routers.traefik-callback.middlewares=oidc-auth"
  - "traefik.http.routers.traefik-callback.service=noop@internal"
```

To protect any service, add the `oidc-auth` middleware to its router. This example shows how to secure the Traefik dashboard, replacing the previous `BasicAuth` method.

```yaml
labels:
  # Apply the OIDC middleware to the Traefik dashboard router
  - "traefik.http.routers.traefik.middlewares=oidc-auth,error-pages,lan-only,security-headers"
```

### Handling Origin IPs from Cloudflare

When you use Cloudflare's proxy (orange cloud), all traffic reaching your server comes from [Cloudflare's IP addresses](https://www.cloudflare.com/ips/). This means tools like `Fail2ban` or your application logs will see Cloudflare's IP, not the actual visitor's IP.

To fix this, we must configure Traefik to trust Cloudflare and look for the real IP in the `CF-Connecting-IP` HTTP header:

```yaml
command:
  # Cloudflare Forwarder Headers
  - "--entrypoints.web.forwardedHeaders.trustedIPs=$HOME_SUBNET,$CF_IPS_V4,$CF_IPS_V6"
  - "--entrypoints.websecure.forwardedHeaders.trustedIPs=$HOME_SUBNET,$CF_IPS_V4,$CF_IPS_V6"
```

### IP Whitelist

We can limit the Traefik API built-in dashboard (and others services too) to
specific IPs. This can be solved with Traefik itself using the [IPAllowList middleware](https://doc.traefik.io/traefik/middlewares/http/ipallowlist/).

And add the next configuration:

```yaml
labels:
  - "traefik.http.routers.traefik.middlewares=lan-only"
  - "traefik.http.middlewares.lan-only.ipallowlist.sourceRange=192.168.0.0/24"
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

### Error pages

We can replace the standard error pages of Traefik and other services with
something original and pretty [error pages](https://github.com/tarampampam/error-pages).

Add the next container:

```yaml
errorpages:
  image: tarampampam/error-pages:latest
  container_name: errorpages
  hostname: errorpages
  restart: unless-stopped
  depends_on:
    - traefik
  environment:
    - TEMPLATE_NAME=$ERROR_PAGES_TEMPLATE
  labels:
    - "traefik.enable=true"
    - "traefik.http.services.errorpages.loadbalancer.server.port=8080"
    - "traefik.http.routers.errorpages.entrypoints=websecure"
    # Fallback for any NON-registered services
    - "traefik.http.routers.errorpages.rule=HostRegexp(`.+`)"
    - "traefik.http.routers.errorpages.priority=10"
    - "traefik.http.routers.errorpages.middlewares=error-pages"
    # --- Error Pages Middleware ---
    - "traefik.http.middlewares.error-pages.errors.status=400-599"
    - "traefik.http.middlewares.error-pages.errors.service=errorpages"
    - "traefik.http.middlewares.error-pages.errors.query=/{status}.html"
```

Setting the `ERROR_PAGES_TEMPLATE` environment variable you can configure the
template to use. You can preview all available templates [here](https://tarampampam.github.io/error-pages/).

### Docker setup

We create an empty `acme.json` file for Let's Encrypt certificates:

    touch $DOCKER_DATA/traefik/acme.json && chmod 600 $DOCKER_DATA/traefik/acme.json

We create our Traefik network:

    docker network create badassnet

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="traefik"
LETS_ENCRYPT_EMAIL="alice@example.org"
CF_DNS_API_TOKEN="supersecret"
CF_IPS_V4="173.245.48.0/20,103.21.244.0/22,103.22.200.0/22,103.31.4.0/22,141.101.64.0/18,108.162.192.0/18,190.93.240.0/20,188.114.96.0/20,197.234.240.0/22,198.41.128.0/17,162.158.0.0/15,104.16.0.0/13,104.24.0.0/14,172.64.0.0/13,131.0.72.0/22"
CF_IPS_V6="2400:cb00::/32,2606:4700::/32,2803:f800::/32,2405:b500::/32,2405:8100::/32,2a06:98c0::/29,2c0f:f248::/32"
HOME_SUBNET="192.168.0.0/24"
ERROR_PAGES_TEMPLATE="connection"
OIDC_SECRET="supersecret"
OIDC_SUBDOMAIN="pocketid"
OIDC_CLIENT_ID="supersecret"
OIDC_CLIENT_SECRET="supersecret"
OIDC_SCOPES="openid,profile,email,groups"
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
- [Traefik HTTP Middlewares: IPAllowList ](https://doc.traefik.io/traefik/middlewares/http/ipallowlist/)
- [Traefik Let's Encrypt Docs](https://doc.traefik.io/traefik/https/acme/)
- [Let's Encrypt Challenge Types](https://letsencrypt.org/docs/challenge-types/)
- [Traefik with Error Pages](https://github.com/tarampampam/error-pages/wiki/Traefik-(docker-compose))
- [Rotating Traefik logs with logrotate](https://geekland.eu/configurar-la-rotacion-de-logs-en-traefik-con-logrotate/)
- [Traefik OIDC Authentication Plugin](https://traefik-oidc-auth.sevensolutions.cc/docs/getting-started)
