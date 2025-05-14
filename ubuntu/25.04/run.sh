#!/bin/sh

# docker run --device /dev/kfd --device /dev/dri --volume /sfs/rocm/:/tmp/rocm -it --rm -p 7022:22 25.04
docker run --volume /sfs/rocm/:/sfs/rocm -it --rm -p 7022:22 25.04


