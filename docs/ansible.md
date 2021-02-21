# Ansible

These Ansible Playbooks and Roles are for preparing an Ubuntu 20.04.x OS to play nicely with Kubernetes and standing up k3s ontop of the nodes.

## Dependancies

[https://taskfile.dev/](https://taskfile.dev/#/) to run taskfiles in .taskfile.

## Commands

Commands to run can be found in my Ansible Taskfile located [here](https://github.com/onedr0p/home-cluster/blob/main/.taskfiles/Taskfile_ansible.yml), e.g.

```bash
# List hosts in my Ansible inventory
task ansible:ping
# Ping hosts in my Ansible inventory
task ansible:ping
```

# Installing

Once a VM/Device has a fresh Ubuntu install (20.04)

```bash
# Install dependancies using taskfile.dev
task ansible:deps


# Install dependancies manually
ansible-galaxy install -r ./ansible/requirements.yml --force
pip3 install -r ./ansible/requirements.txt


# Prepare Ubuntu for k3s install
ansible-playbook -i inventory/home/hosts.yml playbooks/ubuntu/prepare.yml

# Install k3s on Inventory
ansible-playbook -i inventory/home/hosts.yml playbooks/k3s/install.yml
```

