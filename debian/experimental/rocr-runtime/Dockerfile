FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar https://salsa.debian.org/rocm-team/rocr-runtime

RUN cd rocr-runtime; apt build-dep -y .
RUN cd rocr-runtime; gbp buildpackage -us -uc

CMD ["bash"]
