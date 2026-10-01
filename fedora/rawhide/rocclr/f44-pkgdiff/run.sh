#!/bin/sh

rm -rf output
mkdir output

docker build -t pkgdiff . 2>&1 | tee output/docker-build.log
CID=$(docker run -d pkgdiff)
docker wait ${CID}
docker logs ${CID} > output/docker-run.log
docker cp ${CID}:/output/. output/
docker rm -f ${CID}
