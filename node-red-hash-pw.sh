#!/bin/sh

docker exec -d -it node-red /bin/sh -c "mkdir /usr/src/node-red/opt && chmod 777 /usr/src/node-red/opt"
docker cp /root/Node-RED-Container-master/hash-pw.sh node-red:/usr/src/node-red/opt
docker exec -it node-red /bin/sh -c "chmod 777 /usr/src/node-red/opt/hash-pw.sh && /usr/src/node-red/opt/hash-pw.sh"
