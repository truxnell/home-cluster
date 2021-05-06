
# Secret managment

I'm using Mozilla SOPS to encrypt keys in the git archive.  I chose this approach because:

* It allows me to encrypt secrets, and save them into the git repo.
* Instead of encrypting the whole file, you can see the structure/plaintext of the YAML - with only the selected secrets encrypted.
  -  This allows others to view/understand the files, especially the owner
* It is a first-class citizen in Flux, with native support.



Good instructions to setup here:

https://toolkit.fluxcd.io/guides/mozilla-sops/


<!-- Save gpg key to k3s.
```
gpg --export-secret-keys \
--armor <insert PGP key> |
kubectl create secret generic sops-gpg \
--namespace=flux-system \
--from-file=sops.asc=/dev/stdin
``` -->

Enter gpg key as a ansible vault secret, the playbooks install the key before loading flux.
