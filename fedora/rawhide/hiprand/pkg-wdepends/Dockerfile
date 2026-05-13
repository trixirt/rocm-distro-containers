FROM fedora:rawhide

RUN dnf update -y
RUN dnf install -y repoquery

COPY test.sh test.sh

CMD ["/test.sh"]