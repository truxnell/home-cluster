#!/bin/bash
mc admin user add minio loki $LOKI_S3_PASSWORD
mc mb minio/loki
mc admin policy add minio loki-private loki-user-policy.json
mc admin policy set minio loki-private user=loki
