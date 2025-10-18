FROM ubuntu:25.10

RUN sed -i -e 's@Types: deb@Types: deb deb-src@' /etc/apt/sources.list.d/ubuntu.sources
# Installing git-buildpackage will fail without this
RUN echo "MIRRORSITE=http://archive.ubuntu.com/ubuntu" > /etc/pbuilderrc

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN git clone -b debian/latest https://salsa.debian.org/trix/rocm-build-scripts.git
RUN git clone -b debian/latest https://salsa.debian.org/trix/rocm-cmake

# Not building the docs
RUN cd rocm-cmake; DEB_BUILD_PROFILES="nodoc" apt build-dep -y .
RUN DEB_BUILD_PROFILES="nodoc" rocm-build-scripts/build.sh rocm-cmake

RUN cd rocm-build-scripts/b; tar cf /b.tar *.deb

CMD ["bash"]