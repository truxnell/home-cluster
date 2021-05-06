# Installing

# Provision device

Im using Proxmox, so I have created a Ubuntu 20.04 cloud ready image on my nodes.

I clone (manually) as many copies as I need, and align my ansible invnetory to align to IP's.

Then

* Run ansible playbook ubuntu install to prepare the vm's
* Run ansible plabook k3s install to install the cluster
* The k3s install playbook will place a kubeconfig file in the root of the repository - `mv kubeconfig ~/.kube/config` (or your prefered location)
* Run the tasfile ansible:flux:install to install flux and connect to this repository
