# Repository strucutre

Folder structures are important in many projects, and a repostirory for flux (or just k8s yaml) is no exception.

Many folder structures exist and this is the second I have used - and likely not the last.
The way my repo is layed out is not my own design - it is blatantly stolen from members of the k8s@home community.

!!! Info This structure inspired by:

- [bjw-s repo](https://github.com/bjw-s/k8s-gitops/)
- [carpenike's repo](https://github.com/carpenike/k8s-gitops/)
- [xunholy's repo](https://github.com/xunholy/k8s-gitops/)

## General folder structure

The `k8s` folder is blown out and described in the next heading.

```
.
├── .github/                   # all github related files
│   ├── actions                # github actions
│   ├── lint                   # linter settings
│   ├── mkdocs                 # mkdocs settings
│   ├── scripts                # shell scripts
│   └── workflows              # github workflows
├── .taskfiles/                # taskfiles (https://taskfile.dev)
│   └── <taskfile>.yaml        # various taskfiles for faster/easier k8s managment
├── .vscode/                   # vscode files
│   ├── extensions.json        # recommended repository extensions
│   ├── settings.json          # repositroy settings (mainly favorites)
│   └── yaml.code-snippets     # yaml snippets i use from time to time
├── docs/                      # mkdocs folder (markdown for this site)
│   ├── _includes              # markdown includes (abbreviations)
│   ├── _static                # static assets (css, js, etc)
│   ├── .draft                 # dump folde for mini-drafts or notes for docs
│   └── src/                   # root of this site
│       ├── <topic_heading>/   # folder named for a topic
│       │   └── <topics>.md    # individual markdown files for this topic
│       ├── index.md           # landing page
│       └── CNAME              # CNAME record for this site - required for custom domain on github pages
├── k8s/                       # All flux/k8s yaml folder
│   └──  (continued below)
├── tools/                     # Assorted deployment yaml for a few cluster tools
│   └── <tool>.yaml            # tool deployment yaml
├── .gitignore                 # file list to be ignored by git
├── .pre-commit-config.yaml    # git precommit settings
├── .sops.yaml                 # sops settings
└── taskfile.yaml              # tasfile setup (points to .taskfile folder)
```

## K8s folder structure - cluster & flux bootstrap

This is the 'main' folder for the entire cluster, hence its own section.  The below outlines all the folders that enable the bootstrap of the cluseter, flux installation, loading of repositories and global/cluster variables&secrets.

Manifests (all the apps to run the cluster) will be, again, listed seperatly below.

```
.
└── k8s/
    ├── charts/
    │   └── kah-common-chart
    ├── clusters/
    │   ├── hegira/
    │   │   ├── flux/
    │   │   │   ├── deploy/
    │   │   │   │   ├── cluster-config.yaml
    │   │   │   │   ├── cluster-orcestration.yaml
    │   │   │   │   ├── cluster-repositories.yaml
    │   │   │   │   └── manage-flux.yaml
    │   │   │   ├── orchestration/
    │   │   │   │   └── <namespace>.yaml
    │   │   │   ├── repositiores/
    │   │   │   │   ├── git
    │   │   │   │   └── helm
    │   │   │   ├── vars/
    │   │   │   │   ├── cluster-config.yaml
    │   │   │   │   └── cluster-secrets.sops.yaml
    │   │   │   ├── gotk-monitoring.ymal
    │   │   │   └── gotk-sync.yaml
    │   │   └── deploy-cluster.yaml
    │   ├── integrations/
    │   │   └── cilium-quick-install
    │   └── sidero/
    │       └── <same folder structure as hegira>
    ├── global/
    │   ├── repositories/
    │   │   ├── git/
    │   │   └── helm/
    │   └── vars/
    │       ├── global-config.yaml
    │       └── global-secrets.sops.yaml
    └── manifests/
        └── <namespace folders>

```

## K8s folder structure - app manifests

This lists the manifest folder, which contains all the namespace declerations and everything to run the apps for the cluster.

Note this is stored globally, and the two clusters call on specific folders in this manifest to install the apps.  This is just my approach to lean toward aDRY (Dont Repeat Yourself) paradigm.

This enables multiple clusters to re-use the exact same manifests - often using cluster-specific variables to ensure the app is installed in a cluster-specific manner.


!!! Note Not every foler is here
    I havent added every folder in here or apps in folder.  I'm only breaking out important/unique ones for explanation.
    Most apps follow the below format, for example the downloads folder/namespace
    ```
    .
    └── downloads/                      # folder for apps, same as namespace name
        ├── qbittorrent/                # app folder
        │   ├── config-pvc.yaml         # app persistent volume claim
        │   ├── helm-release.yaml       # helm release for app
        │   └── kustomization.yaml      # kustomization, calling above two files
        ├── sabnzbd/                    # app folder
        │   ├── config-pvc.yaml         # app persistent volume claim
        │   ├── helm-release.yaml       # helm release for app
        │   └── kustomization.yaml      # kustomization, calling above two files
        ├── namespace.yaml              # namespace yaml for namespace (downloads)
        └── kustomization.yaml          # kustomization only calling on namespace (not apps)
    ```

```
.
└── manifests/                      # folder for all namespaces
    ├── cert-manager/               # cert-manager folder
    │   ├── base/                   # helm-release for
    │   ├── certificate/            # cert-manager certificate requests
    │   └── config/                 # cert-manager config
            ├── clusterissuer.yaml  # cert-manaager clusterissuer (letsencrypt config)
            ├── prometheusrule.yaml # prometheus monitoring rule for certs
            ├── secret.sops.yaml    # cloudflare api-token secret
    ├── databases                   # namespace for databases (postgresql, maraidb)
    ├── default/                    # namespace for sidero setup
    │   ├── clusters/               # sidero cluster yaml
    │   ├── environments/           # sidero environment yaml
    │   ├── serverclasses/          # sidero serverclass yaml
    │   └── servers/                # sidero server yaml
    ├── downloads                   # downloaders (sabnzbd, qbittorrent, etc)
    ├── flux-system/                # flux-system add-ons
    │   ├── monitoring/             # prometheus rule & podmonitor for monitoring flux
    │   ├── notifications/          # discord & github notifications
    │   └── webhook/                # github webhook to call flux on github push for instant reconciliation
    ├── games                       # game servers (factorio, foundrytts)
    ├── home-automation             # home automation (hass, nodered, mqtt)
    ├── kasten-io/                  # kasten-io backup solution
    │   └── k10/
    │       ├── blueprints/         # k10 blueprint yaml (extensions of backup method)
    │       ├── monitoring/         # prometheus monitoring rules
    │       ├── policies/           # k10 policies (backup schedules)
    │       └── profiles/           # k10 profiles (backup locations)
    ├── kube-system                 # extra apps for cluster operatorions (CNI, plugins, housekeeping)
        ├── cillium                 # this manifest is applied over the top of the quick-install bootstrap
    ├── media                       # media players/servers (Plex, dizquetv)
    ├── network-system              # network apps/ingress (metallb, traefik, externaldns)
    ├── organizarrs                 # organizer apps (*arr's)
    ├── rook-ceph/                  # rook-ceph (distributed storage system)
    │   ├── add-ons/                # rook-ceph addons (grafana dashboards)
    │   ├── cluster/                # rook-ceph cluster definition
    │   ├── operator/               # rook-ceph operator
    │   └── snapshot-controller/    # snapshot controller addon (for kasten snapshots)
    ├── security                    # security apps (vaultwarden, SSO)
    ├── services                    # general service apps (hajimari, joplin-server, syncthing)
    ├── sidero-system               # sidero system apps (arm64 patch, loadbalancer)
    ├── system-monitoring           # system monitoring (prometheus, grafana, botkube)
    └── vpn                         # vpn apps (pod gateway, used for qbittorrent/namespace routing)
```