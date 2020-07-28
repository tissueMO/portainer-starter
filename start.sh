#!/bin/bash

PORTAINER_DATA_DIR=/var/local/portainer/data

if [ ! -f $PORTAINER_DATA_DIR ]; then
  mkdir -p $PORTAINER_DATA_DIR
fi

docker service rm portainer

docker service create \
  --name portainer \
  --replicas 1 \
  --publish mode=host,target=8000,published=8000 \
  --publish mode=host,target=9000,published=9000 \
  --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  --mount type=bind,src=$PORTAINER_DATA_DIR,dst=/data \
  portainer/portainer
