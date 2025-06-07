FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar https://salsa.debian.org/rocm-team/hipify

RUN cd hipify; apt build-dep -y .
RUN cd hipify; gbp buildpackage -us -uc

CMD ["bash"]
