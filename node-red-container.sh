#!/bin/sh

################################################################################
# Author: Olarn Sukasem
#
# Description: Files management in Node-RED container
#
################################################################################

container_name=node-red
docker_images=nodered/node-red:latest-12
# Login to root then cd to directory "/home/rock/Documents/Projects/node-red"
MYPWD=${PWD}
echo "${MYPWD}"
# Check container status
if sudo docker ps -a --format '{{.Names}}' | grep -Eq "^${container_name}\$"; then
	echo 'This container already exists'
else
	# Run Container
	docker run -d --rm -u root -it -p 1880:1880 --device=/dev/ttyUSB0 --privileged -v "${MYPWD}"/data:/root/data --name node-red "${docker_images}"

	sleep 5

	# Copy node-red modules to /root/data directory 
	docker exec -d -it node-red /bin/sh -c "cd /usr/src/ && cp -R /usr/src/* /root/data"

	sleep 5

	# find "${MYPWD}"/data -type d -exec chmod 777 {} \;
	# find "${MYPWD}"/node-red -type d -exec chmod 777 {} \;

	# Move node-red modules from /data to /node-red
	mv "${MYPWD}"/data/* "${MYPWD}"/

	# Remove Container
	docker rm -f node-red

	sleep 3

	# Run Container again
	docker run -d --rm -u root -it -p 1880:1880 --device=/dev/ttyUSB0 --privileged -v "${MYPWD}"/data:/data -v "${MYPWD}"/node-red:/usr/src/node-red/ --name node-red "${docker_images}"
fi