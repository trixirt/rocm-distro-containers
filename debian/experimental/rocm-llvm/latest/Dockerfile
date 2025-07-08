FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN git clone -b debian/latest https://salsa.debian.org/trix/rocm-llvm.git

RUN cd rocm-llvm; apt build-dep -y .
RUN cd rocm-llvm; debian/do_build.sh


CMD ["bash"]