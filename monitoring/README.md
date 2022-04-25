# Monitoring

- [About](#about)
- [Configuration](#configuration)
  * [Enable SNMP](#enable-snmp)
  * [Generate SNMP config](#generate-snmp-config)
  * [Prometheus config](#prometheus-config)
  * [Docker setup](#docker-setup)
  * [Grafana dashboards](#grafana-dashboards)
- [Useful links](#useful-links)

## About

Let's convert our Synology NAS in our monitoring center. For this we will use:

- **Grafana**: dashboard to analyze and visualize the metrics of our machines.
- **Prometheus**: database where all the metrics of efficient way.
- **Exporters**: plugins capable of converting metrics into data understandable
  by Prometheus.

We are going to start by monitoring the NAS itself, taking advantage of the SNMP
protocol that comes by default with Synology. SNMP is a protocol that exposes
state metrics of a machine so we can make use of it to obtain the metrics, but
for this we must use an exporter in concrete that allows Prometheus to interpret
the data. In the end we will have a diagram like the following:

    SNMP (NAS) <--- SNMP EXPORTER <--- Prometheus <--- Grafana

Grafana will connect to Prometheus, which in turn will query the SNMP Exporter,
which transforms the data that it in turn extracts from Synology itself exposed
through the SNMP protocol. 

## Configuration

### Enable SNMP

We need to make sure the SNMP service is enabled on Synology, so we access
Control Panel -> Terminal & SNMP -> SNMP:

- **Enable SNMP service**: `true`
- **SNMPv1,SNMPv2c service**: `true`
- **Community**: `whatever`

Community is an important attribute that works as a password. To verify that it
works, from our linux workstation we can do the following:

    snmpwalk -v 1 -c whatever <YOUR_NAS_IP>

You should see a bunch of metrics. 

### Generate SNMP config

In order to use the SNMP Exporter, it is necessary to generate an SNMP file that
serves as configuration with a generator that is available in the project's own
repo. To use it:

    git clone https://github.com/prometheus/snmp_exporter.git
    cd snmp_exporter
    make mibs

This will generate a directory `snmp_exporter/generator/mibs`, with SNMP metrics
from different manufacturers, including Synology. With them, we can Generate a
configuration file as follows:

    docker run --rm -ti -v "${PWD}:/opt/" snmp-generator generate

This will generate a `snmp.yml` file with the necessary metrics. This file is not
only contains the metrics of Synology, also those of other devices, so
that we can eliminate everything that does not interest us.

Very important, that in the end, we have to specify the community in this
archive. Resulting example:

```yml
# WARNING: This file was auto-generated using snmp_exporter generator, manual changes will be lost.
synology:
  walk:
  - 1.3.6.1.2.1.2
  - 1.3.6.1.2.1.25.2
  # ...
  auth:
    community: whatever
``` 

### Prometheus config

We create a `prometheus.yml` file:

```yml
scrape_configs:
  - job_name: "nas"
    static_configs:
      - targets:
          - "<YOUR_NAS_IP>"   # Synology NAS IP exposing SNMP metrics
    metrics_path: "/snmp"
    params:
      module: [synology]
    scrape_interval: 10s
    scrape_timeout: 5s
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: <YOUR_NAS_IP>:9116 # The SNMP exporter's real hostname:port
```

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
GRAFANA_DOMAIN_NAME="grafana.domain.tld"
PROMETHEUS_DOMAIN_NAME="prometheus.domain.tld"
PUID=1000
```

And deploy:

    docker-compose up -d

### Grafana dashboards

Check out the next specific Grafana dashboards for Synology:

- [Synology NAS Details](https://grafana.com/grafana/dashboards/14284)
- [Synology SNMP DashBoard](https://grafana.com/grafana/dashboards/13516)

## Useful links

- [SNMP Exporter](https://github.com/prometheus/snmp_exporter)
- [Prometheus](https://prometheus.io/)
- [Grafana](https://grafana.com/grafana/)
- [Grafana on your Synology](https://mariushosting.com/how-to-install-grafana-on-your-synology-nas/)
- [SNMP to Prometheus](https://brendonmatheson.com/2021/02/07/step-by-step-guide-to-connecting-prometheus-to-pfsense-via-snmp.html)
- [Telegram notifications from Grafana](https://elblogdelazaro.org/posts/2021-09-20-configurar-alarmas-telegram-en-grafana/)
