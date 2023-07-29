# NAS Docker-compose

Ive tried a few alternatives to running services on my NAS (Ubuntu + ZFS)

Ansible scripts setting up podman + systemctl to run containers, and k3s at one point.

Plain old docker compose 'just works' without the overhead & hiccups. A short bash script gives me faux-gitops, it just has to be run on a cronjob.
