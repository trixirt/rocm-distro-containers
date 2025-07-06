FROM ubuntu:24.04

RUN sed -i -e 's@Types: deb@Types: deb deb-src@' /etc/apt/sources.list.d/ubuntu.sources
# Installing git-buildpackage will fail without this
RUN echo "MIRRORSITE=http://archive.ubuntu.com/ubuntu" > /etc/pbuilderrc

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN git clone -b noble/6.4 https://salsa.debian.org/trix/rocm-smi.git

RUN cd rocm-smi; apt build-dep -y .
RUN cd rocm-smi; debian/do_build.sh


CMD ["bash"]