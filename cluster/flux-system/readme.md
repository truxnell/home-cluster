# flux-system director

This directory and some `gotk-*` files created when you bootstrap your cluster's github with flux.

Note the `kustomization.yaml` file ties it all together - if you need to add further `gotk-*.yaml` files or patches you need to list them in the `kustomization.yaml` file.

# helm-repositories

Here I have the repositories in `./helm-chart-repositories`, which are pointed to by the `gotk-custom-kustomization.yaml` file.

