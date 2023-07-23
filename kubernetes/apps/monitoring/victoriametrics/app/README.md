# VictoriaMetrics stack

# Intro

VictoriaMetrics is a (somewhat) drop-in replacement to the ubiquitous Prometheus/Thanos/Alertmanager stack.
It is more lightweight and space efficient with metrics, and is very snappy when running on nvme only.

Some posts:
https://medium.com/israeli-tech-radar/all-at-once-monster-multi-site-monitoring-platform-with-victoriametrics-ebed75c3c5e

# Components

## VMOperator

A operator that comes with CRD's and manages rollouts of other VM components based on CRD manifests.
Specs for CRD's etc can be found https://docs.victoriametrics.com/operator/api.html

## VMAgent

_Stateless_
A 'tiny but brave agent' that scrapes sources for metrics and sends them to VMInsert for ingestion via remote_write.
Has a UI where you can view configured targets and their status
Landing page looks bare but has some links to the expected targets/discovery/relabel debug/

## VMsingle

_Stateless_
A fast time-scale database. For non-HA installs.

## VMCluster

_Stateless_
A fast time-scale database. For HA installs.

## VMStorage

_Stateful_
Stores the raw data and returns queried data based on given timerange/labels.

## VMSelect

_Stateful_
Runs queries on distributed storagedevices
Also contains a UI called VMUI that is like a souped-up version of the Prometheus UI
VMUI can be found at https://vmselect.domain.tld/select/0/vmui/
(The landing page doesnt show you anything except a link to docs!)

## VMInsert

_Stateless_
Writes metrics from VMAgent and spreads writes to VMStorage pods

## VMAlert

_Stateless_
Watches metrics and triggers alerts. Not as comprehensive as Prometheus Alertmanager so we send its alerts to Alertmanager for further action
Has a Ui to view raw alerts triggered like prometheus does

## Alertmanager

_Stateful_ (Optional)
Our beloved Prometheus Alertmanager. Takes alerts from VMAlert and does the needful
This is still where you work with/get notifications from/silence.

## Grafana

_Stateless_ (Optional)
Our beloved Grafana. Queries VMSelect as needed if selected as a datasource.

# Differences to Prometheus/Loki/Thanos

# Setup

## Lite (vmsingle)

Not yet personally attempted

## High-Avaliable (vmcluster)

Key points:

- Set `replicaCount:` to 3
- Added `extraArgs - dedup.minScrapeInterval` to VMStorage, VMCluster and VMSelect.
- Changed VMAgent scrapeInterval to 60s instead of default 30seemed
- Added my own custom additinalscrapes in prometheus format to a secret and added into VMAgent
- VMUi is sort of hidden - its in the vmselect pod but you have to browse to /select/0/vmui/ to load it, the base URL just shows a link to docs

## Grafana

- Called the VictoriaMetrics datasource 'Prometheus' as it was easier than trying to get all my graphs to change datasource (some seem to be a bit too hardcoded)
- VM Datasource needs `/select/0/promethus` appended to the URL
- Added VictoriaMetrics dashboards to my setup manually - there isn't currenly a `forceDeployDashboards` like prom-kube-stack
