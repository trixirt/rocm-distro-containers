FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar https://salsa.debian.org/rocm-team/miopen

RUN cd miopen; apt build-dep -y .
RUN cd miopen; gbp buildpackage -us -uc

CMD ["bash"]
