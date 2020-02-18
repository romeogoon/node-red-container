#!/bin/sh

################################################################################
# Author: Olarn Sukasem
#
# Description: Files management in Node-RED container
#
################################################################################

container_name=node-red
# Check container status
if sudo docker ps -a --format '{{.Names}}' | grep -Eq "^${container_name}\$"; then
	echo 'This container already exists'
else
	# Run Container
	docker run -d --rm -u root -it -p 1880:1880 -v ~/Documents/Projects/node-red/data:/root/data --name node-red nodered/node-red:latest-12

	sleep 5

	# Copy node-red modules to /root/data directory 
	docker exec -d -it node-red /bin/sh -c "cd /usr/src/ && cp -R /usr/src/* /root/data"

	sleep 5

	# Move node-red modules from /data to /node-red
	mv /root/Documents/Projects/node-red/data/* /root/Documents/Projects/node-red/

	# Remove Container
	docker rm -f node-red

	sleep 3

	# Run Container again
	docker run -d --rm -u root -it -p 1880:1880 -v ~/Documents/Projects/node-red/data:/data -v ~/Documents/Projects/node-red/node-red:/usr/src/node-red/ --name node-red nodered/node-red:latest-12
fi
