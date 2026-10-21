#!/bin/sh

rm -rf output
mkdir output

docker build -t check . 2>&1 | tee output/docker-build.log
CID=$(docker run -e HIP_VISIBLE_DEVICES=0 --device /dev/kfd --device /dev/dri -d check)
docker wait ${CID}
docker logs ${CID} > output/docker-run.log
docker cp ${CID}:/test.log output/
docker rm -f ${CID}

if [ -f /usr/bin/pi ]; then
    pi < ~/ai/fedora-pi-prompts/test/docker-check.txt 2>&1 output/analysis.log
fi
