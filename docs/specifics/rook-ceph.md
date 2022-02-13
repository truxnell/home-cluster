# Rook-Ceph

## Login Credentials

> Ref: [https://github.com/rook/rook/blob/master/Documentation/ceph-dashboard.md]

After you connect to the dashboard you will need to login for secure access. Rook creates a default user named admin and generates a secret called rook-ceph-dashboard-password in the namespace where the Rook Ceph cluster is running. To retrieve the generated password, you can run the following:

```bash
kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o jsonpath="{['data']['password']}" | base64 --decode && echo
```
