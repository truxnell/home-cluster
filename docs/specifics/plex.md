# Plex

# Config

TRaSH guide link

# Firewall

I have plex in a group in my udm-pro - ensure this IP is changed if the loadbalancer IP ever changes.

# claim token

`plex.tv/claim` url for claim token into secrets - one off

# endpointmon

Needs to monitor plex.domain.tld/web/index.html as base domain returns 401

# Port forward

Im using a load balancer, with my UDM pro port forwaring 32400 -> Plex Loadbalancer IP -> Plex clusterIP.  This gets me to a connected remote status.

# Set LAN ips in network

While working over VLANS, need to set ip in network settings of server.  Lets use all rfc ranges to be safe?
```
10.0.0.0/8,172.16.0.0/12,192.168.0.0/16
```

# NUC hardware decoding

Needs

suplemental groups
```
        - 44
        - 109
        - 100
```

request: gpu

intel-gpu-plugin

node-feature-detector to get custom-intel-gpu label