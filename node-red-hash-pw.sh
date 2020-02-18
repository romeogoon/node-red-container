#!/bin/sh

docker exec -d -it node-red /bin/sh -c "mkdir opt && chmod 777 opt"
docker cp node-red-hash-pw.sh node-red:/usr/src/node-red/opt

node -e "console.log(require('bcryptjs').hashSync(process.argv[1], 8));" olarn