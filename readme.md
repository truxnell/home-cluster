# Truxnell's home k8s cluster

<div align="center">

[![Docs](https://img.shields.io/static/v1.svg?color=009688&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=Cluster&message=Docs)](https://k8s.voltaicforge.com "Documentation for this repository.")
[![Discord](https://img.shields.io/discord/673534664354430999?color=7289da&label=DISCORD&style=for-the-badge&logo=discord)](https://discord.gg/sTMX7Vh "k8s at home Discord Community")
[![GitHub stars](https://img.shields.io/github/stars/Truxnell/home-cluster?color=green&style=for-the-badge)](https://github.com/Truxnell/home-cluster/stargazers "This repo star count")
[![GitHub last commit](https://img.shields.io/github/last-commit/Truxnell/home-cluster?color=purple&style=for-the-badge)](https://github.com/Truxnell/home-cluster/commits/main "Commit History")
[![Talos](https://img.shields.io/badge/OS-Talos-success?style=for-the-badge)](https://talos.dev "Talos OS")
[![Release](https://img.shields.io/github/v/release/Truxnell/home-cluster?style=for-the-badge)](https://github.com/Truxnell/home-cluster/releases "Repo releases")
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=for-the-badge&logo-pre-commit)](https://github.com/pre-commit/pre-commit "Precommit status")
[![Schedule - Renovate](https://img.shields.io/github/actions/workflow/status/Truxnell/home-cluster/schedule-renovate.yaml?label=Renovate&logo=renovatebot&style=for-the-badge&branch=main)](https://github.com/Truxnell/home-cluster/actions/workflows/schedule-renovate.yaml)

</div>

> [!IMPORTANT]
> As of April 14th, 2024, I am no longer using Kubernetes in my homelab
> 
> Thankyou to everyone that has followed, had questions and learnt from my 
> k8s journey.
>
> My new homelab repo is built with Nix + NixOS at can be found at:
> 
> github: https://github.com/truxnell/nix-config
> 
> docs: https://truxnell.github.io/nix-config/
>
> This will be publically archived for learning purposes but please note
> that it will be outdated.

<div align="center">

![Home Internet](https://status.voltaicforge.com/api/badge/15/status?style=for-the-badge&label=Home%20Internet)
![Plex](https://status.voltaicforge.com/api/badge/1/status?style=for-the-badge&label=Plex)
![Home Assistant](https://status.voltaicforge.com/api/badge/5/status?style=for-the-badge&label=Home%20Assistant)

</div>

## Overview

This repository is my homelab cluster, using tools such as [Flux2](https://github.com/fluxcd/flux2) define the infrastructure as code.

Feel free to open a [GitHub issue](https://github.com/Truxnell/home-cluster/issues/new) if you have any questions!

**Fledgling documentation available at [https://k8s.voltaicforge.com](https://k8s.voltaicforge.com)**

## Donations

If what's in this repository has helped you and would like to donate, consider donating to [onedrop](https://github.com/onedr0p) or [bjw-s](https://github.com/bjw-s) as this repo would not exist without their contributions.

## Sister repos

I use this repo in conjunction with:

- [https://github.com/truxnell/vyos-config](https://github.com/Truxnell/home-udmp-utils). This is my vyos router configuration repo, also setup in a gitops manner. Many thanks to bjw-s [https://github.com/bjw-s](https://github.com/bjw-s) for the inspiration for this setup.

## Stargazers

[![Star History Chart](https://api.star-history.com/svg?repos=truxnell/home-cluster&type=Date)](https://star-history.com/#truxnell/home-cluster&Date)

## License

This repo is available under the MIT License.

Full license details are available in [LICENSE.md](LICENSE.md)
