# Ingress Monitor Controller

## Operator guthub

Allows gitops-y control of uptimerobot.
Operator is 2nd gen behind older annotation version

[https://github.com/stakater/IngressMonitorController]

## Add services via `endpointmonitor`

Storing non-k8s endpoints in imc folder (i.e. main website)

> Ref: [https://github.com/stakater/IngressMonitorController]

`EndpointMonitor` resource can be used to manage monitors on static urls or route/ingress references.

- Specifying url:

```yaml
apiVersion: endpointmonitor.stakater.com/v1alpha1
kind: EndpointMonitor
metadata:
  name: stakater
spec:
  forceHttps: true
  url: https://stakater.com
```

- Specifying route reference:

```yaml
apiVersion: endpointmonitor.stakater.com/v1alpha1
kind: EndpointMonitor
metadata:
  name: frontend
spec:
  forceHttps: true
  urlFrom:
    routeRef:
      name: frontend
```

- Specifying ingress reference:

```yaml
apiVersion: endpointmonitor.stakater.com/v1alpha1
kind: EndpointMonitor
metadata:
  name: frontend
spec:
  forceHttps: true
  urlFrom:
    ingressRef:
      name: frontend
```
