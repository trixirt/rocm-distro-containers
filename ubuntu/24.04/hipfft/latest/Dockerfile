FROM ubuntu:24.04

RUN sed -i -e 's@Types: deb@Types: deb deb-src@' /etc/apt/sources.list.d/ubuntu.sources
# Installing git-buildpackage will fail without this
RUN echo "MIRRORSITE=http://archive.ubuntu.com/ubuntu" > /etc/pbuilderrc

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN mkdir b
RUN cd b; gbp clone https://salsa.debian.org/rocm-team/hipfft

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

# rocm-hipamd
RUN dpkg -i libhiprtc6_*
RUN dpkg -i libhiprtc-builtins6_*
RUN dpkg -i libamdhip64-6_*
RUN dpkg -i libamdhip64-dev_*

# rocminfo dependencies
RUN apt-get install -y pciutils kmod
RUN dpkg -i rocminfo_*

# hipcc
RUN dpkg -i hipcc_*

# rocm-cmake
RUN dpkg -i rocm-cmake_*

# rocfft
RUN dpkg -i librocfft0_*
RUN dpkg -i librocfft-dev_*

# Not building the docs
RUN cd b/hipfft; DEB_BUILD_PROFILES="nodoc nocheck" apt build-dep -y .
# misspelled
RUN cd b/hipfft; DEB_BUILD_PROFILE="nodoc nocheck" DEB_BUILD_PROFILES="nodoc nocheck" gbp buildpackage -us -uc

RUN cd b; tar cf /b.tar *.deb

CMD ["bash"]