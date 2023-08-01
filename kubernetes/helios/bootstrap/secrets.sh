#!/bin/bash

# Didnt feel like adding external-secrets to my NAS cluster so Im just mananging secrets 'manually'
kubectl create secret kopia-to-b2 -n default --from-env-file <$(doppler secrets download -p tf-b2 -c prd --no-file --format docker)
kubectl create secret generic -n cert-manager cloudflare-api-token-secret --from-env-file <(doppler secrets download -p cert-manager -c prd --no-file --format docker)
