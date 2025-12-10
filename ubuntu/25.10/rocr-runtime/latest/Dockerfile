FROM ubuntu:25.10

RUN sed -i -e 's@Types: deb@Types: deb deb-src@' /etc/apt/sources.list.d/ubuntu.sources
# Installing git-buildpackage will fail without this
RUN echo "MIRRORSITE=http://archive.ubuntu.com/ubuntu" > /etc/pbuilderrc

RUN apt update --fix-missing
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN git clone -b debian/latest https://salsa.debian.org/trix/rocm-build-scripts.git
RUN git clone -b debian/latest https://salsa.debian.org/trix/rocr-runtime.git

COPY l.tar  /

RUN tar xf l.tar

# rocm-llvm dependencies
RUN apt-get install -y libxml2-dev libffi-dev libncurses-dev python3-pygments libzstd-dev libz3-dev

# Missing depends
RUN apt-get install -y libnuma-dev

RUN dpkg -i libllvm20-rocm_*
RUN dpkg -i libclang1-20-rocm*
RUN dpkg -i llvm-20-rocm-linker-tools*
RUN dpkg -i libclang-common-20-rocm-dev*
RUN dpkg -i libclang-cpp20-rocm*
RUN dpkg -i clang-20-rocm*
RUN dpkg -i clang-tools-20-rocm*
RUN dpkg -i clang-format-20-rocm*
RUN dpkg -i clang-tidy-20-rocm*
RUN dpkg -i libclang-20-rocm-dev*
RUN dpkg -i liblld-20-rocm_*
RUN dpkg -i lld-20-rocm*
RUN dpkg -i liblld-20-rocm-dev*
RUN dpkg -i llvm-20-rocm-tools*
RUN dpkg -i llvm-20-rocm-runtime*
RUN dpkg -i llvm-20-rocm*
RUN dpkg -i llvm-20-rocm-dev*
RUN dpkg -i rocm-device-libs-20-rocm*

RUN cd rocr-runtime; apt build-dep -y .
RUN rocm-build-scripts/build.sh rocr-runtime

RUN cd rocm-build-scripts/b; tar cf /b.tar *.deb

CMD ["bash"]