FROM fedora:rawhide

RUN dnf update -y
RUN dnf -y install dnf install rocm-runtime-static

COPY test.sh /test.sh

CMD ["/test.sh" ]