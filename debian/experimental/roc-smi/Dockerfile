FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar https://salsa.debian.org/rocm-team/roc-smi

RUN cd roc-smi; apt build-dep -y .
RUN cd roc-smi; gbp buildpackage -us -uc

CMD ["bash"]
