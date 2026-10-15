FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

COPY test.sh /test.sh

CMD ["/test.sh"]