# Githup workflows

Linters and renovate bot liberated from [https://github.com/bjw-s/k8s-gitops](https://github.com/bjw-s/k8s-gitops)

# Flux update (flux.yaml)
 
Flux updater, which is not picked up by renovate-bot.  This sets up a schedule to pull the repo into a container, install flux to the right folder, and open a PR for any resulting changes to gotk-components.yaml.  Should only require changes to the path in the flux install command (https://github.com/Truxnell/home-cluster/blob/main/.github/workflows/flux.yaml#L29)[https://github.com/Truxnell/home-cluster/blob/main/.github/workflows/flux.yaml#L29] and possily the matrix if you dont use/cange names of production-staging.