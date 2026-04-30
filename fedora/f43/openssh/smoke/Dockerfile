FROM fedora:43

RUN dnf update -y
RUN dnf install -y openssh-clients

CMD ["ssh", "-vvv", "fedorapeople.org" ]