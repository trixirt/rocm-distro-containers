FROM rockylinux:8

# Failure to update
# FROM quay.io/centos/centos:stream8


RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools \
 emacs

RUN dnf install -y \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

CMD ["bash"]