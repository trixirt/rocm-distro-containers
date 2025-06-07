FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar https://salsa.debian.org/rocm-team/rocm-llvm

RUN cd rocm-llvm; apt build-dep -y .
RUN cd rocm-llvm; gbp buildpackage -us -uc

CMD ["bash"]
