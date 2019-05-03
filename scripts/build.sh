#!/bin/bash
OPENSTACK_RC=/root/openrc

source $OPENSTACK_RC

glance image-list

read -r -p "Enter Image ID that you want to download: " IMAGE_ID

IMAGE_NAME=`openstack image show $IMAGE_ID -f value -c name`

echo -e "\nDownloading..."
glance image-download --file /var/log/$IMAGE_NAME.raw $IMAGE_ID --progress &&

echo -e "\nConverting image format..." &&
qemu-img convert -f raw -O qcow2 /var/log/$IMAGE_NAME.raw /var/log/$IMAGE_NAME.qcow2 &&

openstack image create --public --disk-format qcow2 --container-format bare --file /var/log/$IMAGE_NAME.qcow2 $IMAGE_NAME

echo -e "\n\033[32mSucceeded\033[0m"
