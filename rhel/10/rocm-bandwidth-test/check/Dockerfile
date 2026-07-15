FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN dnf install -y rocm-bandwidth-test

CMD ["rocm-bandwidth-test"]

