#!/bin/sh

################################################################################
# Author: Olarn Sukasem
#
# Description: Generate a hash
#
################################################################################

# Create and change permission
docker exec -d -it node-red /bin/sh -c "mkdir /usr/src/node-red/opt && chmod 777 /usr/src/node-red/opt"

# Copy hash-pw.sh to container
docker cp /root/Node-RED-Container-master/hash-pw.sh node-red:/usr/src/node-red/opt

# Change permission and execute hash-pw.sh
docker exec -it node-red /bin/sh -c "chmod 777 /usr/src/node-red/opt/hash-pw.sh && /usr/src/node-red/opt/hash-pw.sh"
