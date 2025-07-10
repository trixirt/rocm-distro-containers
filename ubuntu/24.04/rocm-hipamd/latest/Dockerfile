FROM ubuntu:24.04

RUN sed -i -e 's@Types: deb@Types: deb deb-src@' /etc/apt/sources.list.d/ubuntu.sources
# Installing git-buildpackage will fail without this
RUN echo "MIRRORSITE=http://archive.ubuntu.com/ubuntu" > /etc/pbuilderrc

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN git clone -b debian/latest https://salsa.debian.org/trix/rocm-hipamd.git

COPY l.tar  /
RUN tar xf l.tar

# rocm-llvm dependencies
RUN apt-get install -y libxml2-dev libffi-dev libncurses-dev python3-pygments

RUN dpkg -i libllvm-rocm_*
RUN dpkg -i libclang1-rocm_*
RUN dpkg -i llvm-rocm-linker-tools_*
RUN dpkg -i libclang-rt-rocm-dev_*
RUN dpkg -i libclang-common-rocm-dev_*
RUN dpkg -i libclang-cpp-rocm_*
RUN dpkg -i clang-rocm_*
RUN dpkg -i clang-tools-rocm_*
RUN dpkg -i clang-format-rocm_*
RUN dpkg -i clang-tidy-rocm_*
RUN dpkg -i libclang-rocm-dev_*
RUN dpkg -i lld-rocm_*
RUN dpkg -i llvm-rocm-tools_*
RUN dpkg -i llvm-rocm-runtime_*
RUN dpkg -i llvm-rocm_*
RUN dpkg -i llvm-rocm-dev_*
RUN dpkg -i llvm-rocm-dev_*
RUN dpkg -i rocm-device-libs_*
RUN dpkg -i lld-rocm_*
RUN dpkg -i libamd-comgr3_*.deb
RUN dpkg -i libamd-comgr-dev_*.deb

# libhsa dependencies
RUN apt-get install -y libdrm-amdgpu1 libdrm2 libelf1t64 libnuma1

RUN dpkg -i libhsa-runtime64-1_*
RUN dpkg -i libhsa-runtime-dev_*


RUN cd rocm-hipamd; apt build-dep -y .
RUN cd rocm-hipamd; debian/do_build.sh

RUN cd b; tar cf /b.tar *.deb

CMD ["bash"]