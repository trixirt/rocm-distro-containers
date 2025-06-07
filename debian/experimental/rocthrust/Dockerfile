FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar https://salsa.debian.org/rocm-team/rocthrust

RUN cd rocthrust; apt build-dep -y .
RUN cd rocthrust; gbp buildpackage -us -uc

CMD ["bash"]
