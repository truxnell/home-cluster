# Fly.io Uptime Kuma

> https://noted.lol/easy-off-site-monitoring-with-fly-io-and-uptime-kuma/

## Setup (from scratch, create fly.toml)

Install `flyctl`

`flyctl auth login`
to log into accounts

`flyctl launch --image louislam/uptime-kuma:1.18.1`

Enter name (i.e. uptime-kuma)
No to postgres/deploy

Edit fly.toml as above url

```fly volumes create kuma_data --region syd --size 1```

Then `fly deploy`

# Apply existing fly.toml

In this folder (with fly.toml)
Create app (must be unique)

`flyctl apps create`
Enter app name `voltaicforge-kuma`

Create volume for uptime kuma

`fly volumes create kuma_data --region syd --size 1`

`fly deploy`


# Add custom DNS

`fly volumes certs add sub.domain.tld`

Get ip list from  deployment's

`fly ips list`

Then add ip4 into your A name and ipv6 into AAAA of your custom domain

Check the fly.io url to see information on your certificate.  Grab the info from here on adding the `_acme_challenge` CNAME and add it into cloudflare - but do not proxy! (Ensure DNS only)

Once cert is registered, delete the acme challenge info (Should autorenew right?)
