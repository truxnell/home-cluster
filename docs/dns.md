# DNS Setup

## Map

## Unifi UDM_PRO

- nextdns
- wireguard
- dnsmasq mod for split-dnsmasq
- ipxe mod
- bostchicken scripts
- udm is a docker!

### dnsmasq

### dns

Split domains, and using subdomains to point to loadbalancers.

### pxe boot

And pxe boot shenanigans for sidero

### NextDNS

set forwarder in nextdns config, route back to UDM's dnsmasq

```
nextdns config set -forwarder=domain.tld.=192.168.2.1
nextdns restart
```

## cloudflare

## uptime monitor

## Discord notifications

### Uptimemonitor

### cloudflare-ddns

## external-dns
