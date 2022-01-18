# DNS Setup

## Map

## Unifi UDM_PRO

- nextdns
- wireguard
- dnsmasq mod for split-dnsmasq
- ipxe mod
- bostchicken scripts
- udm is a docker!

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
