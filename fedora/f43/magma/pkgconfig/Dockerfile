FROM fedora:43

RUN dnf update -y

RUN dnf install -y magma-devel
COPY test.sh .

CMD ["bash", "-c", "./test.sh" ]
