#!/bin/sh

docker build -t dnf . 2>&1 | tee docker-build.log
CID=$(docker run -d dnf)
docker wait ${CID}
docker logs ${CID} > docker-run.log
docker rm -f ${CID}

