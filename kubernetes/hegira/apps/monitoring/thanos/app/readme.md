# Redacted secret reference

This is a redacted copy of the Thanos secret for reference.

Note that the s3 URL does not have http(s) appended - this is implied by setting the `insecure` flag to true or false.

```yaml
# yamllint disable
apiVersion: v1
kind: Secret
metadata:
  name: thanos-objstore-secret
  namespace: monitoring
stringData:
  objstore.yml: |-
    type: s3
    config:
      bucket: <bucket>
      endpoint: <s3 url - no http/https>
      access_key: <s3 key>
      secret_key: <s3 secret>
      insecure: true
```
