# Blackbox exporter

I had intermittent failures for ICMP pings - fixed with payload size increase

```
ts=2018-09-19T10:54:05.647899261Z caller=icmp.go:162 module=icmp target=probed-host.domain.zz level=warn msg="Timeout reading from socket" err="read ip 0.0.0.0: raw-read ip4 0.0.0.0: i/o timeout"
```

payload_size=64 to fix intermittent ICMP ping failures
https://github.com/prometheus/blackbox_exporter/issues/360
