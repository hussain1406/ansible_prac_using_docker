#!/bin/bash
user_name=hussain14
docker rmi $user_name/ansible:alpine > /dev/null 2>&1 || true
docker build -t $user_name/ansible:alpine . -f Dockerfile-Ansible > /dev/null 2>&1
rm -rf id_rsa.pub
docker container create --name ansible $user_name/ansible:alpine
docker cp ansible:/home/ansible/.ssh/id_rsa.pub .
docker rm ansible
for ubuntu_version in 18 20 22
do
	docker rmi -f $user_name/ubuntu:${ubuntu_version}.04-ssh > /dev/null 2>&1
	if [[ $? -ne 0 ]]
        then
                echo "You have some docker containers which depend on $user_name/ubuntu:${ubuntu_version}.04-ssh. If you don't remove them the image will not be built."
                read -p "Remove them (y/n) " ans
                if [[ $ans == y ]]
                then
                        docker rm $(docker ps -aq --filter "ancestor=$user_name/ubuntu:${ubuntu_version}.04-ssh")
                else
                        continue
                fi
        fi
	echo "Removed Ubuntu ${ubuntu_version}.04 ssh image from Docker"
	echo "Building Ubuntu ${ubuntu_version}.04 ssh image from Dockerfile"
	docker build -t $user_name/ubuntu:${ubuntu_version}.04-ssh . -f Dockerfile-Ubuntu${ubuntu_version}> /dev/null 2>&1
	if [[ $? -ne 0 ]]
	then
		echo "An Error Occured while building Image for Ubuntu ${ubuntu_version}.04"
	else
		echo "Successfully Built Image for Ubuntu ${ubuntu_version}.04"
	fi
done

for rocky_version in 8 9
do
	docker rmi -f $user_name/rockylinux:${rocky_version}-ssh > /dev/null 2>&1
	if [[ $? -ne 0 ]]
	then
		echo "You have some docker containers which depend on $user_name/rockylinux:${rocky_version}-ssh. If you don't remove them the image will not be built."
		read -p "Remove them (y/n) " ans
		if [[ $ans == y ]]
		then
			docker rm $(docker ps -aq --filter "ancestor=$user_name/rockylinux:${rocky_version}-ssh")
		else
			continue
		fi
	fi
	echo "Removed Rocky Linux ${rocky_version} ssh image from Docker"
	echo "Building Rocky Linux ${rocky_version} ssh image from Dockerfile"
	docker build -t $user_name/rockylinux:${rocky_version}-ssh . -f Dockerfile-Rocky${rocky_version} > /dev/null 2>&1
	if [[ $? -ne 0 ]]
        then
                echo "An Error Occured while building Image for Rocky Linux ${rocky_version}"
        else
                echo "Successfully Built Image for Rocky Linux ${rocky_version}"
        fi
done


