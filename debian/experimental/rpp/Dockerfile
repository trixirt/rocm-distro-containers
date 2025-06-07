FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar https://salsa.debian.org/rocm-team/rpp

RUN cd rpp; apt build-dep -y .
RUN cd rpp; gbp buildpackage -us -uc

CMD ["bash"]
