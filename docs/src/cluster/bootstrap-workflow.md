---
hide:
  - toc
---
## Bootstrap flow

The folder-structure doc still makes it a bit tricky to see the dependancies and workflow for the cluster.  Ill attempt to clarify that a bit with a confusing speghetti flowchart.

!!! Note "* Steps require reconciliation of prior step"
    In the deployment subgraph, each step uses ```dependsOn`` in the yaml to require the previous step fully reconciled before it proceeds.

    In this way, there is a layering where the cluster will load the repositories, flux managment layer, variables, and finally orchestration to start installing apps in order.

```mermaid
    flowchart TB
        ka[kubectl apply] --> dc[deploy-cluster.yaml]
        subgraph deploy
            cr --> mf["deploy/manage-flux.yaml*"]
            dc --> cr["deploy/cluster-repositories.yaml"*]
            mf --> cc["deploy/cluster-config.yaml*"]
            cc --> co["deploy/cluster-orchestration*"]
        end
        subgraph cluster-repositories
            direction LR
            cgr[Cluster Git Repositories]
            chr[Cluster Helm Repositories]
        end
        subgraph global-repositories
            direction LR
            ggr[Global Git Repositories]
            ghr[Global Helm Repositories]
        end
        cluster-repositories --> global-repositories
        dc --> cluster-repositories
        subgraph cluster-vars
            direction LR
            cf[Cluster Config]
            cs[Cluster Secrets]
        end
        subgraph global-vars
            gf[Global Config]
            gs[Global Secrets]
        end
        cc --> cluster-vars
        cluster-vars --> global-vars
        subgraph orchestration
            direction LR
            cm[Cert Manager]
            db[Databases]
            df[Downloads]
            ga[Games]
            ha[Home-Automation]
            ks[Kasten-io]
        end
        co --> cm
        co --> db
        co --> df
        co --> ga
        co --> ha
        co --> ks
        subgraph manifests
            mcm[Cert Manager yaml]
            mdb[Database yaml]
            mdf[Downloads yaml]
            mga[Games yaml]
            mha[Home-Automation yaml]
            mks[Kasten-io yaml]
        end
        cm --> mcm
        db --> mdb
        df --> mdf
        ga --> mga
        ha --> mha
        ks --> mks
```
