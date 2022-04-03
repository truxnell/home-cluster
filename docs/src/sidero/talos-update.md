# Talos update

Talos updates are really simple:

Simply change the version number at the end of the --image tag.

```bash
❯ talosctl upgrade --nodes 10.8.20.40 \
            --image ghcr.io/siderolabs/installer:v1.0.0-beta.0
NODE         ACK                        STARTED
10.8.20.40   Upgrade request received   2022-03-06 21:29:55.796035744 +1100 AEDT m=+4.542098674
```

After a successful upgrade, its recommended to then loop back on the sidero install yaml to bump the install version for if/when you need to install a new node/reset a existing node.
