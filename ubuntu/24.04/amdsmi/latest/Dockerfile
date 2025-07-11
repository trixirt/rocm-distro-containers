FROM ubuntu:24.04

RUN sed -i -e 's@Types: deb@Types: deb deb-src@' /etc/apt/sources.list.d/ubuntu.sources
# Installing git-buildpackage will fail without this
RUN echo "MIRRORSITE=http://archive.ubuntu.com/ubuntu" > /etc/pbuilderrc

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN mkdir b
RUN cd b; gbp clone https://salsa.debian.org/rocm-team/amdsmi

# Not building the docs
RUN cd b/amdsmi; DEB_BUILD_PROFILES="nodoc nocheck" apt build-dep -y .
RUN cd b/amdsmi; DEB_BUILD_PROFILES="nodoc nocheck" gbp buildpackage -us -uc

RUN cd b; tar cf /b.tar *.deb

CMD ["bash"]