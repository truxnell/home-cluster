# Kubed

Kubed is a cluster secret copier

I am using this to copy the tls certificate from cert-manager across all namespaces.  By default, it is only avaliable to where it is created, which causes issues using it to generate ssl certificates for ingress in other namespaces.
