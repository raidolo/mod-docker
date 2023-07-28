#!/bin/bash
export USER_NAME=$(id -un)
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
export GROUP_NAME=$(id -gn)
export PUID=$(id -u)
export PGID=$(id -g)

mkdir -p /home/$USER_NAME/mod-user-files
mkdir -p /home/$USER_NAME/mod-data
mkdir -p /home/$USER_NAME/mod-pedalboards

#docker build  --rm -f "mod-host/Dockerfile" --build-arg PUID=${PUID} --build-arg PGID=${PGID}  -t mod-host "mod-host" 
#docker build  --rm -f "mod-plugin-builder/Dockerfile" --build-arg PUID=${PUID} --build-arg PGID=${PGID} -t mod-plugin-builder "mod-plugin-builder" 
docker build  --rm -f "mod-ui/Dockerfile" -t mod-ui "mod-ui"

docker-compose up  --no-build mod-ui
