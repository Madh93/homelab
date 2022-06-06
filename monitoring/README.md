# Monitoring

- [About](#about)
  * [Metrics](#metrics)
  * [Logs](#logs)
- [Configuration](#configuration)
  * [Enable SNMP](#enable-snmp)
  * [Generate SNMP config](#generate-snmp-config)
  * [Prometheus config](#prometheus-config)
  * [Loki config](#loki-config)
  * [Promtail config](#promtail-config)
  * [Docker setup](#docker-setup)
  * [Enable log sending](#enable-log-sending)
  * [Grafana dashboards](#grafana-dashboards)
- [Useful links](#useful-links)

## About

Let's convert our Synology NAS in our monitoring center. For this we will use:

- **Grafana**: dashboard to analyze and visualize the metrics and logs of our machines.
- **Prometheus**: database where all the metrics of efficient way.
- **Exporters**: plugins capable of converting metrics into data understandable
  by Prometheus.
- **Loki**: like Prometheus, but for logs.
- **Promtail**: agent which ships the contents of local logs to Loki.

We are going to start by monitoring the NAS itself.

### Metrics

Synoloy offers the SNMP service. SNMP is a protocol that exposes state metrics
such as uptime, throughput, temperature, interface errors, CPU utilization, and
memory usage. To store this data in Prometheus we need to use an SNMP exporter.

Diagram:

    SNMP (NAS) <--- SNMP EXPORTER <--- Prometheus <--- Grafana

### Logs

Our Synology NAS can be configured as a syslog client to send the logs to a
syslog server for centralized management (Loki).

Diagram:

    Syslog client (NAS) ---> Promtail ---> Loki <--- Grafana

Both metrics and logs, Grafana will retrieve metrics from Prometheus and logs
from Loki.

## Configuration

### Enable SNMP

We need to make sure the SNMP service [is enabled on Synology](https://kb.synology.com/en-us/DSM/help/DSM/AdminCenter/system_snmp?version=7), so we access
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

### Loki config

We create a `loki.yml` file:

```yml
auth_enabled: false

server:
  http_listen_port: 3100

common:
  path_prefix: /tmp/loki
  storage:
    filesystem:
      chunks_directory: /tmp/loki/chunks
      rules_directory: /tmp/loki/rules
  replication_factor: 1
  ring:
    instance_addr: 127.0.0.1
    kvstore:
      store: inmemory

schema_config:
  configs:
  - from: 2020-10-24
    store: boltdb-shipper
    object_store: filesystem
    schema: v11
    index:
      prefix: index_
      period: 24h

ruler:
  alertmanager_url: http://localhost:9093
```

### Promtail config

We create a `promtail.yml` file:

```yml
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://loki:3100/loki/api/v1/push

scrape_configs:
  - job_name: system
    static_configs:
      - targets:
          - localhost
        labels:
          job: varlogs
          host: NAS     # Synology NAS custom host name
          __path__: /var/log/*.log
  - job_name: syslog_listener
    syslog:
      listen_address: 0.0.0.0:1514
      idle_timeout: 60s
      label_structured_data: yes
      labels:
        job: syslog
    relabel_configs:
      - source_labels: ['__syslog_message_hostname']
        target_label: host
  - job_name: docker
    docker_sd_configs:
      - host: unix:///var/run/docker.sock
        refresh_interval: 30s
    relabel_configs:
      - source_labels: ['__meta_docker_container_name']
        regex: '/(.*)'
        target_label: container
      - source_labels: ['__meta_docker_network_name']
        regex: '(.*)'
        target_label: network
```

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
GRAFANA_DOMAIN_NAME="grafana.domain.tld"
LOKI_DOMAIN_NAME="loki.domain.tld"
PROMTAIL_DOMAIN_NAME="promtail.domain.tld"
PROMETHEUS_DOMAIN_NAME="prometheus.domain.tld"
PUID=1000
```

And deploy:

    docker-compose up -d

### Enable log sending

To [send logs](https://kb.synology.com/en-us/DSM/help/LogCenter/logcenter_client?version=7) to the Promtail Syslog listener, go to Log Center -> Log Sending:

- **Send logs to a syslog server**: `true`
- **Syslog server hostname**: `localhost`
- **Syslog server port**: `1514`
- **Transfer protocol**: `TCP`
- **Log format**: `IETF (RFC 5424)`

### Grafana dashboards

Check out the next specific Grafana dashboards for Synology:

- [Synology NAS Details](https://grafana.com/grafana/dashboards/14284)
- [Synology SNMP DashBoard](https://grafana.com/grafana/dashboards/13516)

## Useful links

- [SNMP Exporter](https://github.com/prometheus/snmp_exporter)
- [Prometheus](https://prometheus.io/)
- [Grafana](https://grafana.com/grafana/)
- [Grafana Loki Syslog All In One Syslog Deployable Stack](https://github.com/lux4rd0/grafana-loki-syslog-aio)
- [Grafana on your Synology](https://mariushosting.com/how-to-install-grafana-on-your-synology-nas/)
- [SNMP to Prometheus](https://brendonmatheson.com/2021/02/07/step-by-step-guide-to-connecting-prometheus-to-pfsense-via-snmp.html)
- [Telegram notifications from Grafana](https://elblogdelazaro.org/posts/2021-09-20-configurar-alarmas-telegram-en-grafana/)
- [SNMP in Synology](https://kb.synology.com/en-us/DSM/help/DSM/AdminCenter/system_snmp?version=7)
- [Log Sending in Synology](https://kb.synology.com/en-us/DSM/help/LogCenter/logcenter_client?version=7)
