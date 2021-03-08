## My Home Cluster
[![Discord](https://img.shields.io/badge/discord-chat-7289DA.svg?maxAge=60&style=flat-square)](https://discord.gg/7PbmHRK)     [![update-flux](https://github.com/Truxnell/home-cluster/actions/workflows/flux.yaml/badge.svg)](https://github.com/Truxnell/home-cluster/actions/workflows/flux.yaml)     [![renovate](https://github.com/Truxnell/home-cluster/actions/workflows/renovate.yaml/badge.svg)](https://github.com/Truxnell/home-cluster/actions/workflows/renovate.yaml)     [![GitHub last commit](https://img.shields.io/github/last-commit/Truxnell/home-cluster?color=purple&style=flat-square)](https://github.com/billimek/k8s-gitops/commits/main)     [![sops-encrypt](https://github.com/Truxnell/home-cluster/actions/workflows/sops.yaml/badge.svg)](https://github.com/Truxnell/home-cluster/actions/workflows/sops.yaml)
## :book:&nbsp; Overview

This repository is my homelab cluster, using tools such as [Flux2](https://github.com/fluxcd/flux2) and Ansible to define the infrastructure as code.

Feel free to open a [Github issue](https://github.com/Truxnell/home-cluster/issues/new) if you have any questions!

## Tools
| Tool | Description |  
|---|---|
| GitCrypt | Encrypt secrets to git |
| Taskfile.dev | Manage and run short tasks out of .taskfile directory |
| Flux | Sync this repo to k3s instance to enable infrastructure as code |
| Ansible | Manage inventory of computers, run series of pre-defined commands to allow repeatable environments |


