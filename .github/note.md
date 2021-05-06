# Github workflows

Linters and renovate bot liberated from [https://github.com/bjw-s/k8s-gitops](https://github.com/bjw-s/k8s-gitops)


# Variables required
## git-crypt-key

git-crypt key needs to be put in github to enable sops script.
### Encode git-crypt key to base64 for entry into github
```bash
git-crypt export-key git-crypt.key

base64 git-crypt.key > git-crypt.asc

cat git-crypt.asc
```

Enter git-crypt.asc output into github repo secret GIT_CRYPT_KEY

## gpg-key for sops

Get key from gpg
```bash
gpg --list-secret-keys
```

```bash
gpg --export-secret-keys <your key fingerprint> | base64
```

Copy into repo secret GPG_SIGNING_KEY

# Flux update (flux.yaml)

Flux updater, which is not picked up by renovate-bot.  This sets up a schedule to pull the repo into a container, install flux to the right folder, and open a PR for any resulting changes to gotk-components.yaml.  Should only require changes to the path in the flux install command (https://github.com/Truxnell/home-cluster/blob/main/.github/workflows/flux.yaml#L29)[https://github.com/Truxnell/home-cluster/blob/main/.github/workflows/flux.yaml#L29] and possily the matrix if you dont use/changed names of production-staging.  And change to your name in the commit line.

# Renovate comments

Adds comments in helmrelease files so that renovate-bot can check the repos for updates.  Renovate will not work correctly without these.  This script will regulary check the code and update any helmrelease yaml that does not have the comment (or is incorrect to the source file)
