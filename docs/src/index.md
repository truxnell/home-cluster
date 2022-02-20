# Truxnell's Home-Cluster

This [git repo]() is my homelab, stored in a declaritve yaml format.  This allows me to have a single source of written truth for my homelab, declaring how and where I want it setup.
--8<-- "src/sidero/sidero-intro.md"

This allows me to:

* Version control my changes, allowing easy rollback of breaking patches/tinkering/etc
* Allow for easy reinstall/disaster recovery of a cluster, as everything *except* persistent data is defined here.
* Version control and declare hardware provisioning (Now using [Sidero & Talos](sidero-intro.md)), ensuring repeatable and robust hardware configuration.
    * This can be achieved with tools such as [Terraform](https://www.terraform.io) and [Ansible](https://www.ansible.com) for those wanting to use a more standard OS & deployment.
* With [Sidero](sidero.dev) and [Talos](talos.dev), I can define and provision a cluster by plugging nodes into the network, and having them network PXE boot, install the OS Talos, and have a configuration file applied to them.  This automates and watches my cluster, with no manual intervention required.

# Tech Stack
[<img src="images/mkdocs.png" alt="flux" style=";object-fit:cover;width:200px;height:100px"/>](https://www.mkdocs.org)
[<img src="images/flux-horizontal-color.png" alt="flux" style=";object-fit:cover;width:200px;height:100px"/>](https://fluxcd.io)
[<img src="https://www.sidero.dev/images/logo.svg" alt="flux" style=";width:200px;height:100px"/>](sidero.dev)
[<img src="https://www.talos.dev/images/logo.svg" alt="flux" style=";width:200px;height:100px"/>](https://talos.dev)
[<img src="https://seeklogo.com/images/C/cilium-logo-B9B53FC8EA-seeklogo.com.png" alt="flux" style=";object-fit:contain;width:200px;height:100px"/>](https://cilium.org)
[<img src="https://mp.s81c.com/pwb-production/c4a833f11e311146a23c643651068b75/kasten-logo-inline-by-Veeam-e768bc74-095a-40de-b6b3-fa8abf4a75e6_7998963c-5e38-4285-ac1d-bdcac69e1523.png" alt="flux" style=";object-fit:contain;width:200px;height:100px"/>](https://www.kasten.io)

