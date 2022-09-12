#!/bin/bash
mc admin user add s3 loki $LOKI_S3_PASSWORD
mc mb s3/loki
mc admin policy add s3 loki-private loki-user-policy.json
mc admin policy set s3 loki-private user=loki
