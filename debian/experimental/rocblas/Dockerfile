FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar https://salsa.debian.org/rocm-team/rocblas

RUN cd rocblas; apt build-dep -y .
RUN cd rocblas; gbp buildpackage -us -uc

CMD ["bash"]
