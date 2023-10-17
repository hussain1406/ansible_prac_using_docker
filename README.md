# ansible_prac_using_docker
This repo contains the source code for dockerfiles and docker compose files for creating an environment for ansible and for it to work properly



## Running the docker containers using a simple command!
Run this in your terminal in the same directory as this project:
```bash
docker compose up -d
```
and done! Docker will automatically pull the images and create **6** containers out of which 1 will be the **master container** of ansible and other 5 will have ubuntu and rockylinux (open-source rhel.... yeah kind-of)
(2 containers will be of rockylinux (8 and 9 see the docker compose file for more info) and 3 containers will be of ubuntu 22.04)

your hosts file will be mounted inside the `ansible_master_alpine` (The container in which ansible is installed) container and will be kept in sync alongside the `ansible.cfg` file.

to interact with ansible run

```bash
docker exec -it ansible_master_alpine ash
```

to test that everything is working correctly (which it should) run this inside the container (if you ran the command before this you are already inside the container):
```bash
ansible all -m ping
```

Happy Learning!
