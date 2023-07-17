#!/bin/bash
export USER_NAME=$(id -un)
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
export GROUP_NAME=$(id -gn)

mkdir -p /home/$USER_NAME/mod-user-files
mkdir -p /home/$USER_NAME/mod-data
mkdir -p /home/$USER_NAME/mod-pedalboards

docker pull raidolo/mod-ui

docker-compose up  --no-build mod-ui-docker
