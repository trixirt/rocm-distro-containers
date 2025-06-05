How to use containers to do some builds

docker build -t <os> .

docker run --volume <host-path>:<container-path> --privileged -it --rm -p 8080:8080 <os>

docker run --device /dev/kfd --device /dev/dri --security-opt seccomp=unconfined <image_name>

SUSE
https://en.opensuse.org/Docker
sudo systemctl enable docker
sudo systemctl enable docker
sudo usermod -G docker -a $USER
https://hub.docker.com/r/opensuse/tumbleweed

Fedora
https://developer.fedoraproject.org/tools/docker/docker-installation.html
sudo usermod -a -G docker trix

Using /dev/kfd
[root@3ff4ca99a474 test]# rocminfo
ROCk module is loaded
Unable to open /dev/kfd read-write: No such file or directory
Failed to get user name to check for video group membership

cs10
docker pull quay.io/centos/centos:stream10
docker run -it quay.io/centos/centos:stream9 /bin/bash 
