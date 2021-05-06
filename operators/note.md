
# Operators

The second teir of items to load, immediately after the flux-system bootstrap.  This set provides certificate managment, helm sources and docker registery login.
Note: Cert-manager must be loaded completly first before certificates are applied - otherwise a race condition can occur where k8s rejects the certificates as the CRD's for cert-manager are not yet loaded.

This is a large part in why I followed a split approach, between apps/infrastructure/operators.

# helm-chart-repositories

Where all the helm chart sources are stored.

# infra-cert-manager

Certificate manager - the system that requests and keeps https certificates, using letsencrypt.  This must be fully installed *before* the certificates are applied, as they require the CRD to be installed.

# registry-creds

[registry-creds](https://github.com/alexellis/registry-creds): Automate Kubernetes registry credentials, to extend Docker Hub limits.  This is (sadly) necessary to have cluster-wide imagePulls use an authenticated Docker account so that the cluster doesn't get rate-limited and become unable to schedule workloads. This has already happened once.

* [registry-creds/](registry-creds)
