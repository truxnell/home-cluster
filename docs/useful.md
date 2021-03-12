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


## mysql-client in Kubernetes to test your connection to mysql server

kubectl run mysql-client --image=mysql:5.7 -it --rm --restart=Never -- /bin/bash

mysql -h mysql-service -uroot -proot_password -e 'SHOW databases;'

OR

mysql -h mysql-service -uroot -proot_password

then use your mysql queries and commands as usual.
