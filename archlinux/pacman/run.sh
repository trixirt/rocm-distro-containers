#!/bin/sh

docker build -t pacman . 2>&1 | tee docker-build.log
CID=$(docker run -d pacman)
docker wait ${CID}
docker logs ${CID} > docker-run.log
docker rm -f ${CID}

