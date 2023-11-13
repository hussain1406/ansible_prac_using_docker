# Installing Docker

## Step 1 - Reqiurements:
- Docker version >= 24.0.0
- Docker compose version >= 2.0.0

## Step 2 - Installing Docker:
Navigating to the official Docs to install docker is always the best way but if (for some reason) you want to install docker without going to the official docs then here is the warning:
> **⚠️ <span style="color: yellow">Warning:</span>**&emsp;If this doesn't work for you then refer to the official docs because i also copied this from official documentation. 😁 

> **ℹ️ Info:**&emsp;You have to install [Docker Engine](https://docs.docker.com/engine/install/) only if you use Linux. If you are on Windows then install [Docker Desktop](https://docs.docker.com/desktop/install/windows-install/) and the same goes for Mac (Yeah install Docker Desktop).

I will only give instructions for `docker engine` on Ubuntu (20.04 or 22.04 or later, also applicable on derived distros like Linux Mint). As Installing docker in Windows is quite easy.


With that said let's install `docker`:

For Ubuntu (Not for the derivatives such as mint)

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

If you are on Derivative then:
```bash
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```
On `Ubuntu 22.04` based Distros run this:
```bash
# Add the repository to Apt sources:
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
```

On Ubuntu 20.04 based Distros run this:
```bash
# Add the repository to Apt sources:
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
```


Now just install Docker:
```bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### Post Installation:
Add the `docker` group to the current user so that you don't have to run docker each time with the `sudo`:
```bash
sudo usermod -aG docker $USER
```
Logout and then login OR For changes to take effect immediately run:
```bash
newgrp docker
```
Nowadays, Docker Hub won't work for you unless you login to hub.docker.com and use the same id to login in docker.

First Sign Up at [Docker Hub](https://hub.docker.com) then use this to login to docker in your local machine.
```bash
docker login
```
To test that docker is running correctly. Run:
```bash
docker run hello-world
```
If you don't get any error then Congratulations! Docker is now installed in your machine