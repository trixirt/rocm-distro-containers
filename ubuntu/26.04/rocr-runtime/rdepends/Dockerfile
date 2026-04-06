FROM ubuntu:26.04

RUN apt update
RUN apt install -y apt-rdepends

COPY test.sh test.sh

CMD ["/test.sh"]