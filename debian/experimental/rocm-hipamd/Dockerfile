FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar https://salsa.debian.org/rocm-team/rocm-hipamd

RUN cd rocm-hipamd; apt build-dep -y .
RUN cd rocm-hipamd; gbp buildpackage -us -uc

CMD ["bash"]
