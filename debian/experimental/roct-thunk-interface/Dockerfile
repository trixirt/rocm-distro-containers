FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar https://salsa.debian.org/rocm-team/roct-thunk-interface

RUN cd roct-thunk-interface; apt build-dep -y .
RUN cd roct-thunk-interface; gbp buildpackage -us -uc

CMD ["bash"]
