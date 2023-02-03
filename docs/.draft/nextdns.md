# Nextdns config

```text
discovery-dns
mdns all
hardened-privacy false
listen localhost:53
control /var/run/nextdns.sock
max-ttl 5s
setup-router true
auto-activate true
debug false
cache-max-age 0s
use-hosts true
profile 10.8.40.0/24=<REDACTED>  # Specific VLAN (Kids network)
profile <REDACTED>               # Default profile
log-queries false
cache-size 10MB
detect-captive-portals false
bogus-priv true
timeout 5s
max-inflight-requests 256
report-client-info true
forwarder privatedomain.tld.=<coredns instance/w k8s_gateway>
```
