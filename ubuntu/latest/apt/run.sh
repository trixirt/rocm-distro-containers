#!/bin/sh

docker build -t apt . 2>&1 | tee docker-build.log
CID=$(docker run -d apt)
docker wait ${CID}
docker logs ${CID} > docker-run.log
docker rm -f ${CID}

