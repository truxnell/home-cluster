---
title: Sidero & Talos Introduction
---
# Introduction to Sidero & Talos

## Talos

[Talos](https://talos.dev) is a custom Linux OS designed to run kurbenetes and only kurbenetes.  The project aims to deliver a OS that is secure, immutable and minimal.  Talos is API driven and has no ssh, shell or interactive commands.  It runs in memory via squashFS, and mounds the root filesystem as read only.  It comes with Kurbenetes (K8s) installed and ready for production use.

This means a dramatic reduction in attack surface, reduced/eliminates configuration drift and delivers a robust OS for Kurbenetes .

!!! tldr
    Talos is a purpose-build OS for kubentes, and only kurbenetes.  Talos is pared back to only what is needed to run kurbenetes and run it well.  It runs in RAM, has no ssh or shell, and its entirely API driven.  Node configuration is applied via config files, eliminating config drift and need for complex ansible/terraform files.

## Sidero
[Sidero](https://sidero.dev) is a bare metal lifecycle manager for Talos using clusterAPI.  It runs in a managment cluster (i.e. seperate to your main cluster) and allows you to declaratively define your cluster and server requirements in YAML.  Once provisioned, nodes can be PXE booted from Sidero and a Talos config applied to the node - automating the format, install and config of your nodes.

!!! tldr
    In short, it can allow nodes to be connected to the network, PXE boot to a installer, and then wipe/provision the node with TalosOS.  The node will then reboot, getting a configuration file from Sidero.  This will stand up a Master node, etc, and connect workers to your note.

This can be a great alternative to lengthy Ansible/Terraform scripts, which often are taking a general purpose OS like Debian or Ubuntu and trying to strip it down for Kurbenetes.
