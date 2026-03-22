FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y blender wget

COPY test.sh /usr/bin

CMD ["/usr/bin/test.sh"]
