
# Boostrap worker

> Ref: https://www.talos.dev/docs/v0.14/single-board-computers/rpi_4/
Flash eeprom from raspi, i used rpi-imager

Once green blinky, pull sd and put on latest talos metal release

```
curl -LO https://github.com/talos-systems/talos/releases/latest/download/metal-rpi_4-arm64.img.xz
xz -d metal-rpi_4-arm64.img.xz
sudo dd if=metal-rpi_4-arm64.img of=/dev/mmcblk0 conv=fsync bs=4M
```

!! Check version compatibility before installing with sidero table! 
https://github.com/talos-systems/sidero
Youll need to carefully pick a version of talos/k8s that matches sidero's capabilities

Once node is up, bootstrap with a fancy interacive cli-gui
```
talosctl apply-config --insecure --interactive --nodes 10.8.20.20
```

Look at nodes dmesg to see it come up
```
talosctl --nodes 10.8.20.20 dmesg --follow --tail
```

When up, grab kubeconfig
```
talosctl --nodes 10.8.20.20 kubeconfig
```