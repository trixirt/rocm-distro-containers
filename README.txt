How to use containers to do some builds

---
Cheat sheet
Build:
docker build -t <os> .

Run:
docker run --volume <host-path>:<container-path> -it --rm -p 8080:8080 <os>

--volume is option
-p is optiona

---
Setup the host
Some links for different distros

Fedora
https://developer.fedoraproject.org/tools/docker/docker-installation.html

OpenSUSE
https://www.suse.com/c/rancher_blog/introduction-to-using-docker/

---
Trouble shooting

Using /dev/kfd
[root@3ff4ca99a474 test]# rocminfo
ROCk module is loaded
Unable to open /dev/kfd read-write: No such file or directory
Failed to get user name to check for video group membership

Likely need to pass the --device /dev/kfd --device /dev/dri

---
Starting distro images

SUSE
https://en.opensuse.org/Docker
https://hub.docker.com/r/opensuse/tumbleweed

cs10
docker pull quay.io/centos/centos:stream10

---
Examples of uses

1. Test rocfft on OpenSUSE

Go to the OpenSUSE check dir for librocfft0

> cd opensuse/tumbleweed/librocfft0/check

Build the container as root

# docker build -t test .

On a machine with a AMD GPU, run the container

# docker run --device /dev/kfd --device /dev/dri -it --rm test




