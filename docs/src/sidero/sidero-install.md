# Installing sidero

## Planning
I would suggest you read most of the Sidero docs [Sidero](https://sidero.dev/), as well as some of the [Talos](https://talos.dev) Introduction Docs before getting started.
Familiarity with these will be important, the below is more of a fleshed out version of my docs and isn't intended to replace the real thing - especially as there will be drift.

### Hardware considerations

As Sidero runs in its own k8s cluster, you need to have an *always on* second cluster to run.  Sidero really only needs 4GB of RAM and is very light on CPU - making a SBC like the Raspberry Pi 4 4GB a perfect option for home use.  A small PC would also be fine if thats more to your linking.

Ask yourself the following questions:

* How may masters/workers for my cluster.
* CPU arcitecture - will I use strinctly AMD64 or will I have some ARM64 SBC's?
* Will I replace flannel CNI with another?
* Will I use a VIP for HA control plane?


!!! Info "Refer to Sidero documentation on Raspi-4 servers"
    Info here created with reference to Sidero docs - Always read their latest docs!

    > Ref: [https://www.sidero.dev/docs/v0.5/guides/rpi4-as-servers/](https://www.sidero.dev/docs/v0.5/guides/rpi4-as-servers/)

### Software considerations

!!! Info "Refer to Sidero documentation on cli pre-requisites"

    > Ref: [https://www.sidero.dev/docs/v0.5/getting-started/prereq-cli-tools/](https://www.sidero.dev/docs/v0.5/getting-started/prereq-cli-tools/)

Grab the binaries specified:

* `kubectl`
* `clusterctl`
* `talosctl`

!!! Tip
    `talosctl` can be used to stand up a local docker cluster.  This can be amazing for doing testing on sidero, or just local cluster testing in general.  More info [here](talos-dev-cluster.md)

!!! Warning
    Be careful on the verison of `clusterctl` you use.  The latest version may not be the one you need, and *may* not work with the api versions.  Refer to the [Sidero Github](https://github.com/siderolabs/sidero) as they have a compatibility table in the readme.


* Now to setup dhcp for dual booting.  If you do amd64 its not so bad as its one config, but with pi you need to config it to be able to send either arm64 or amd64 binaries.  https://www.sidero.dev/docs/v0.4/getting-started/prereq-dhcp/ is the document.  I had problems here, and i had to mod my udm-pro's dnsmasq with extra configs that get applied at boot to make it work. Codeblock on this page gives you enough info to mod your config - cant see your router on
* I used the bootstrapping section a few times to test - https://www.sidero.dev/docs/v0.4/guides/bootstrapping/.  Cool use case.

## Setup DHCP to serve PXE boot files

!!! Info "Refer to Sidero documentation on DHCP setup"

    > Ref: [https://www.sidero.dev/docs/v0.5/getting-started/prereq-dhcp/](https://www.sidero.dev/docs/v0.5/getting-started/prereq-dhcp/)

This step will be specific to your network
