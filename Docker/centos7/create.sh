#!/bin/bash
docker build -t nextspace-dev .
docker create  -v /dev:/dev --privileged=true -ti  --name nextspace-dev nextspace-dev:latest
docker start nextspace-dev
docker exec -w / -it nextspace-dev git clone https://github.com/nicktelindert/nextspace-build-iso.git
docker exec -w /nextspace-build-iso -it nextspace-dev sh build.sh
docker cp nextspace-dev:/nextspace-build-iso/NEXTSPACE.iso ~/NEXTSPACE.iso
docker stop nextspace-dev
docker container rm nextspace-dev
