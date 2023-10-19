# Learning Environment for Ansible using Docker
This repo contains the source code for dockerfiles and docker compose files for creating an environment for ansible and for it to work properly


## Why?
The one and only reason of running the docker containers is memory effiency and low-hardware friendliness.

In normal circumstances if you were to run 5 machines (may it be VM or Physical). It would cost you more money, RAM and Hardware. By using these containers one can virtually do anything which he/she could have done in those 5 machines using Ansible and by only spending a total amount of 70 MBs of RAM!

This means you can easily run the whole setup on a normal 4 GB RAM Laptop/PC.

That's the actual idea behind creating this project.


## Running the docker containers using a simple command!

If you have not installed `docker` in your machine then [install `docker`](INSTALL_DOCKER.md) first then proceed to the next step.

Run this in your terminal in the same directory as this project:
```bash
docker compose up -d
```
and done! Docker will automatically pull the images and create "**6 containers**" (🚀🚀) out of which 1 will be the **master container** of ansible and other 5 will have ubuntu and Rocky Linux (open-source RHEL.... yeah kind-of)
(2 containers will be of Rocky Linux (8 and 9, see the [compose.yaml](Using%20Docker%20Compose%20to%20run%20the%20environment/compose.yaml) file for more info) and 3 containers will be of Ubuntu 18.04, 20.04 and 22.04)

Your hosts file will be mounted (keep in sync) inside the `ansible_master_alpine` (The container in which ansible is installed) container and will be kept in sync alongside the `ansible.cfg` file.

to interact with ansible run

```bash
docker exec -it ansible_master_alpine ash
```

to test that everything is working correctly (which it should) run this inside the container (if you ran the command before this you are already inside the container):
```bash
ansible all -m ping
```

Happy Learning!
