# Retreiving lost talosconfig

For when you have `kubeconfig` / cluster access, but no talosconfig.

## Retrieve crt/key & admin key from machineconfig.

Run a yaml such as tools/hostpath

```yaml title="tools/hostpath.yaml" linenums="1"
---
apiVersion: v1
kind: Pod
metadata:
  name: ubuntu-debug
  namespace: default
spec:
  containers:
  - name: ubuntu
    image: ubuntu
    command: [ "sleep", "600000" ]
    volumeMounts:
    - mountPath: /hostRoot
      name: root
      readOnly: true
  volumes:
  - name: root
    hostPath:
      path: /
      type: Directory
```

Run pod
```bash
kubectl apply -f tools/hostpath.yaml
pod/ubuntu-debug configured
```

Inside pod:

```bash hl_lines="12 13"
cat hostRoot/system/state/config.yaml 

version: v1alpha1 # Indicates the schema used to decode the contents.
debug: false # Enable verbose logging to the console.
persist: true # Indicates whether to pull the machine config upon every boot.
# Provides machine specific configuration options.
machine:
    type: init # Defines the role of the machine within the cluster.
    token: ckqzyg.uzaqtz5777r97dkp # The `token` is used by a machine to join the PKI of the cluster.
    # The root certificate authority of the PKI.
    ca:
        crt: <machine ca.crt>
        key: <machine ca.key>
    # Extra certificate subject alternative names for the machine's certificate.
    certSANs: []
    #   # Uncomment this to enable SANs.
    #   - 10.0.0.10
    #   - 172.16.0.10
    #   - 192.168.0.10

    ...
```

