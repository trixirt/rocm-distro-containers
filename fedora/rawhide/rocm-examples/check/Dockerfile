FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y rocm-examples

COPY test.sh /

CMD ["/test.sh"]