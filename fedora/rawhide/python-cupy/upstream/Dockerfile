FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 emacs \
 fdupes \
 git \
 gcc-c++ \
 pytest \
 python3-devel \
 python3-cython \
 python3-fastrlock \
 python3-numpy \
 python3-setuptools \
 python3-wheel \
 hipblas-devel \
 hipcub-devel \
 hipfft-devel \
 hiprand-devel \
 hipsparse-devel \
 hipsolver-devel \
 rccl-devel \
 rocblas-devel \
 rocrand-devel \
 rocfft-devel \
 rocm-comgr-devel \
 rocm-hip-devel \
 rocm-rpm-macros \
 rocm-runtime-devel \
 rocsolver-devel \
 rocsparse-devel \
 roctracer-devel \
 rocthrust-devel

# RUN git clone -b v13.6.0 --recursive https://github.com/cupy/cupy.git
RUN git clone --recursive https://github.com/cupy/cupy.git

RUN dnf install -y \
 rocminfo \
 python3-matplotlib

COPY build.sh build.sh

# RUN bash build.sh

CMD ["bash"]