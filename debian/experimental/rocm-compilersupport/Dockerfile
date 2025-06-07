FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar https://salsa.debian.org/rocm-team/rocm-compilersupport

RUN cd rocm-compilersupport; apt build-dep -y .
RUN cd rocm-compilersupport; gbp buildpackage -us -uc

CMD ["bash"]
