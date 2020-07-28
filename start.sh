#!/bin/bash
# e.g. ./start.sh 8000 9000 /var/lib/portainer/data

PORTAINER_DATA_DIR=$3

if [ ! -d $PORTAINER_DATA_DIR ]; then
  mkdir -p $PORTAINER_DATA_DIR
fi

docker service rm portainer

docker service create \
  --name portainer \
  --replicas 1 \
  --publish mode=host,target=8000,published=$1 \
  --publish mode=host,target=9000,published=$2 \
  --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  --mount type=bind,src=$PORTAINER_DATA_DIR,dst=/data \
  portainer/portainer
