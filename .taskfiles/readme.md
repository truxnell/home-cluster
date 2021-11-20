# Taskfiles

These taskfiles are written for use with [https://taskfile.dev](https://taskfile.dev).

These have largely been 'liberated' from [https://github.com/onedr0p/home-cluster/](https://github.com/onedr0p/home-cluster/) as a base for me to springboard off.

# Usage

```bash
task

task: Available tasks for this project:
* ansible:deps:             Install Ansible dependencies
* ansible:list:             List all the k8s nodes
* ansible:ping:             Ping all the k8s nodes
* ansible:playbook:ubuntu:upgrade:     Upgrade all the k8s node's operating system
* secrets:apply:             Apply helm values secrets to the Kubernetes cluster
* secrets:generate:             Generate Helm value secrets
```

# Installing Ansible dependancies

```bash
task ansible:deps
```
