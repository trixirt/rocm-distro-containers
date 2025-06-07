FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar https://salsa.debian.org/rocm-team/rocm-device-libs

RUN cd rocm-device-libs; apt build-dep -y .
RUN cd rocm-device-libs; gbp buildpackage -us -uc

CMD ["bash"]
