FROM ubuntu:24.04

RUN sed -i -e 's@Types: deb@Types: deb deb-src@' /etc/apt/sources.list.d/ubuntu.sources
# Installing git-buildpackage will fail without this
RUN echo "MIRRORSITE=http://archive.ubuntu.com/ubuntu" > /etc/pbuilderrc

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN git clone -b debian/latest https://salsa.debian.org/trix/rocminfo.git

COPY l.tar  /
RUN tar xf l.tar

# libhsa dependencies
RUN apt-get install -y libdrm-amdgpu1 libdrm2 libelf1t64 libnuma1

RUN dpkg -i libhsa-runtime64-1_*
RUN dpkg -i libhsa-runtime-dev_*

RUN cd rocminfo; apt build-dep -y .
RUN cd rocminfo; debian/do_build.sh

RUN cd b; tar cf /b.tar *.deb

CMD ["bash"]