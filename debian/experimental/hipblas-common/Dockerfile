FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar https://salsa.debian.org/rocm-team/hipblas-common

RUN cd hipblas-common; apt build-dep -y .
RUN cd hipblas-common; gbp buildpackage -us -uc

CMD ["bash"]
