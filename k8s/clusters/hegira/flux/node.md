# Install flux

flux install --version=v0.19.0 --export | kubectl apply -f -
kubectl apply -k k8s/clusters/hegira
