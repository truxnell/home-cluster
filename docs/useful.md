## Useful commands

- Delete stuck objects (NSs, PVs, PVCs)
  ```
  kubectl patch <object type> <object name> -p '{"metadata":{"finalizers": []}}' --type=merge
  ```

```bash
NAMESPACE=infra-longhorn                                                                                                                                                   
kubectl get namespace $NAMESPACE -o json > $NAMESPACE.json
sed -i -e 's/"kubernetes"//' $NAMESPACE.json
kubectl replace --raw "/api/v1/namespaces/$NAMESPACE/finalize" -f ./$NAMESPACE.json

```