FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar https://salsa.debian.org/rocm-team/rocm-cmake

RUN cd rocm-cmake; apt build-dep -y .
RUN cd rocm-cmake; gbp buildpackage -us -uc

CMD ["bash"]
