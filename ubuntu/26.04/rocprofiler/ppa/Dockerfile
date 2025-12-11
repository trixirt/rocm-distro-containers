FROM ubuntu:26.04

RUN sed -i -e 's@Types: deb@Types: deb deb-src@' /etc/apt/sources.list.d/ubuntu.sources
# Installing git-buildpackage will fail without this
RUN echo "MIRRORSITE=http://archive.ubuntu.com/ubuntu" > /etc/pbuilderrc

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild software-properties-common retry

RUN add-apt-repository -y ppa:bullwinkle-team/rocm-devel

RUN git clone -b bullwinkle/ubuntu/devel https://git.launchpad.net/~bullwinkle-team/ubuntu/+source/rocprofiler

WORKDIR /rocprofiler

RUN apt-get build-dep . -y
# retry every 120 sec +- 60 sec for 10 times
RUN retry -d 120 -j 60 -t 10 uscan --download-current-version
RUN dpkg-buildpackage -uc -us 

CMD ["bash"]
