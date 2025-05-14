#!/bin/sh

docker run --device /dev/kfd --device /dev/dri --volume /sfs/rocm/mocking/fedora-rawhide-rawhide/:/tmp/rh -it --rm -p 7022:22 x


