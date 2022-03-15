
# Repository strucutre

Folder structures are important in many projects, and a repostirory for flux (or just k8s yaml) is no exception.

Many folder structures exist and this is the second I have used - and likely not the last.
The way my repo is layed out is not my own design - it is blatantly stolen from members of the [k8s@home](https://discord.gg/7PbmHRK) community.

!!! Info "This folder structure inspired by"
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

## K8s folder structure - Cluster & Flux bootstrap

This is the 'main' folder for the entire cluster, hence its own section.  The below outlines all the folders that enable the bootstrap of the cluseter, flux installation, loading of repositories and global/cluster variables&secrets.

Manifests (all the apps to run the cluster) will be, again, listed seperatly below.

!!! Question "Still confused?"
    Still confused by this?  The [bootstrap page](bootstrap-workflow.md) doc may help you visualize how this hangs together.  Perhaps.

```yaml
.
└── k8s/                                            # (1)
    ├── charts/                                     # Extra charts
    │   └── kah-common-chart                        # Clone of k8s common chart
    ├── clusters/                                   # All cluster-specific yaml
    │   ├── hegira/                                 # Prod cluster yaml
    │   │   ├── flux/                               # Flux yaml
    │   │   │   ├── deploy/                         # Deployment-specific yaml
    │   │   │   │   ├── cluster-config.yaml         # kustomize to apply '../vars' folder
    │   │   │   │   ├── cluster-orcestration.yaml   # kustomize to apply '../orchestration' folder
    │   │   │   │   ├── cluster-repositories.yaml   # kustomize to apply '../repositories' folder
    │   │   │   │   └── manage-flux.yaml            # kustomize to apply flux from its gitrepo
    │   │   │   ├── orchestration/                  # app orchestration yaml
    │   │   │   │   └── <namespace>.yaml            # yaml per namespace, refers to 'k8s/manifests/<namespace>/<app>' folders
    │   │   │   ├── repositiores/                   # cluster-specific repositories
    │   │   │   │   ├── git                         # git repositories (namely this one)
    │   │   │   │   └── helm                        # cluster-specific helm repos
    │   │   │   ├── vars/                           # cluster-specific variables
    │   │   │       ├── cluster-config.yaml         # cluster specific open vars
    │   │   │       └── cluster-secrets.sops.yaml   # cluster-specific secret vars
    │   │   └── deploy-cluster.yaml                 # cluster bootstrap to be applied manually.
    │   ├── integrations/                           # folder for extra manifests
    │   │   └── cilium-quick-install/               # minimal deployment of cilium to get cluster running
    │   └── sidero/                                 # sidero cluster
    │       └── <same folder structure as hegira>   # same structure as above
    ├── global/                                     # global resources for all clusters
    │   ├── repositories/                           # global repositories
    │   │   ├── git/                                # global git repos
    │   │   └── helm/                               # global helms
    │   └── vars/                                   # global vars
    │       ├── global-config.yaml                  # global open vars
    │       └── global-secrets.sops.yaml            # global secrets
    └── manifests/                                  # app manifests
        └── <namespace folders>                     # folders per namespace
            └── <app folder>                        # app folder
                └── <app yaml>                      # app yaml
```

1.  All k8s related yaml

We can see here the key differences between clusters will be:

- Their cluster specific variables
- Their orchestration folder, which will call specific portions of the global manifest folder

Its possible to also have differing cluster repositories, but with this being a mono-repository that is unlikely

!!! Question "Why 'hegira' for the cluster name?"
    While many use generic names for servers & clusters, aligning to the 'servers are not pets' doctorine that tools like k8's bring, I still need to get my nerd on with a personal cluster.

    I got the idea for Hegira from Dan Simmons [Hyperion Cantos](https://en.wikipedia.org/wiki/Hyperion_Cantos).  It ties into the naming of the sidero cluster (technocore) and in general the theme of AI & Humanity that is portraied in the books

    Hegira is also defined as *a journey especially when undertaken to escape from a dangerous or undesirable situation*, a somewhat medieval Latin translation of an Arabic word that can be translated to 'migration' or 'exodus', which actually somewhat fits the journey my homelab has taken over the years.

## K8s folder structure - App Manifests

This lists the manifest folder, which contains all the namespace declerations and everything to run the apps for the cluster.

Note this is stored globally, and the two clusters call on specific folders in this manifest to install the apps.  This is just my approach to lean toward a DRY (Dont Repeat Yourself) paradigm.

This enables multiple clusters to re-use the exact same manifests - often using cluster-specific variables to ensure the app is installed in a cluster-specific manner.


!!! Note "Not every folder is listed"
    I havent added every folder in here or apps in folder.  I'm only breaking out important/unique ones for explanation.
    Most apps follow the below format, for example the downloads folder/namespace

    ```yaml
    .
    └── downloads/                      # (1)
        ├── qbittorrent/                # (2)
        │   ├── config-pvc.yaml         # (3)
        │   ├── helmrelease.yaml       # (4)
        │   └── kustomization.yaml      # (5)
        ├── sabnzbd/                    # (8)
        │   ├── config-pvc.yaml         # (9)
        │   ├── helmrelease.yaml       # (10)
        │   └── kustomization.yaml      # (11)
        ├── namespace.yaml              # (6)
        └── kustomization.yaml          # (7)
    ```

    1.  Folder for apps, same as namespace name
    2.  App folder
    3.  App persistent volume claim - usually named `app_name-config-v1`.  The version control `v1` allows easy upgrade to pvc's if we want to change sizing.
    4.  Helm release for app
    5.  Kustomization, calling the config-pvc.yaml and helmrelease.yaml
    6.  Namespace resource file
    7.  Kustomize for namespace only.  Note this file, unlike other repos, does not call upon the apps - it only refers to and creates the namespace.
    8.  App folder
    9.  App persistent volume claim - usually named `app_name-config-v1`.  The version control `v1` allows easy upgrade to pvc's if we want to change sizing.
    10.  Helm release for app
    11.  Kustomization, calling the config-pvc.yaml and helmrelease.yaml

!!! Question "Why declare PVC's independantly"
    We dont rely on the helm chart to generate a PVC for us - we prefer to declare them seperately and definitively.
    With the normal persistent volume policy of `Delete` in most persistant storage configs, anytime the PVC is removed the storage system will delete the PV - and any data it contains!  So if you make changes to the PVC or delete the helm release - its possible you will ***__lose__*** your data.  Specifying a PVC seperatly helps proect agains this.

    It also allows us to version control the pvc, which Ii useful if we need to change pvc size later.

```
.
└── manifests/                      # folder for all namespaces
    ├── cert-manager/               # cert-manager folder
    │   ├── base/                   # helm-release for
    │   ├── certificate/            # cert-manager certificate requests
    │   └── config/                 # cert-manager config
    │       ├── clusterissuer.yaml  # cert-manaager clusterissuer (letsencrypt config)
    │       ├── prometheusrule.yaml # prometheus monitoring rule for certs
    │       └── secret.sops.yaml    # cloudflare api-token secret
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


