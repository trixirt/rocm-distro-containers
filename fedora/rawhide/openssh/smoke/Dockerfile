FROM fedora:rawhide

RUN dnf update -y
RUN dnf install -y openssh-clients

CMD ["ssh", "-vvv", "fedorapeople.org" ]