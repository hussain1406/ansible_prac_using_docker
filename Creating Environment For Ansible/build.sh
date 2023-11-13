#!/bin/bash
remove_image () {
	image_name=$1
	docker rmi $image_name &> /dev/null
	if [[ $? -ne 0 ]]
	then
		echo -e "You have some docker containers which depend on $image_name.\nIf you don't remove them the image will not be built."
        read -p "Remove them (y/n) " ans
		if [[ $ans == y ]]
        then
            docker rm $(docker ps -aq --filter "ancestor=$image_name") &> /dev/null
			docker rmi -f $image_name &> /dev/null
			echo "Removed $image_name image from Docker"
			return 0
        else
			echo -e "\n\nDocker Image $image_name is not removed and therefore this image will not be rebuilt.\nIf you want to create this image you can remove the running or stopped container first, then delete this image and create a new one instead"
			return 1
        fi
	fi
}

build_image () {
	image_name=$1
	image_file=$2
	echo "Building $image_name image from Dockerfile"
	docker build -t "$image_name" . -f "$image_file" &> /dev/null
	if [[ $? -ne 0 ]]
	then
		echo "An Error Occured while building Image: $image_name"
	else
		echo "Successfully Built Image: $image_name"
	fi
}

user_name=hussain14

remove_image "$user_name/ansible:alpine"
build_image "$user_name/ansible:alpine" Dockerfile-Ansible

# Copying id_rsa.pub from ansible container to later hardcore them in the ssh images of other docker containers
rm -rf id_rsa.pub
docker container create --name ansible $user_name/ansible:alpine &> /dev/null
docker cp ansible:/home/ansible/.ssh/id_rsa.pub . &> /dev/null
docker rm ansible &> /dev/null

for ubuntu_version in 18 20 22
do
	remove_image "$user_name/ubuntu:${ubuntu_version}.04-ssh"
	if [[ $? -eq 0 ]]
	then
		build_image "$user_name/ubuntu:${ubuntu_version}.04-ssh" "Dockerfile-Ubuntu$ubuntu_version"
	fi	
done

for rocky_version in 8 9
do
	remove_image $user_name/rockylinux:${rocky_version}-ssh
	if [[ $? -eq 0 ]]
	then
		build_image $user_name/rockylinux:${rocky_version}-ssh Dockerfile-Rocky${rocky_version}
	fi	
done


