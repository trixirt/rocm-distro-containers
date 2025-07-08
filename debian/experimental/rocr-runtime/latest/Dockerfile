FROM debian:experimental

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN git clone -b debian/latest https://salsa.debian.org/trix/rocr-runtime.git

RUN cd rocr-runtime; apt build-dep -y .
RUN cd rocr-runtime; debian/do_build.sh


CMD ["bash"]