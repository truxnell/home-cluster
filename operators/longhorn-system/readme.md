# Longhorn

> Note: Longhorn _must_ be installed in the longhorn-system namespace.

Longhorn is a distributed filesystem solution, which I use to replicate across two nodes

Note: The default number of replicas longhorn tries to create is 3. If you have 2 nodes you need to set the value `defaultClassReplicaCount` to 2 - else longhorn will run PVC's degraded.

Longhorn data is stored on nodes at `/var/lib/longhorn/`
