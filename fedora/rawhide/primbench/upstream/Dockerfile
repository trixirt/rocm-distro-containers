FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 git \
 ninja-build \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo \
 amdsmi-devel

RUN git clone https://github.com/ROCm/rocm-libraries.git
RUN cp rocm-libraries/shared/primbench/primbench.hpp /usr/include/

RUN dnf install -y hipcc gcc-c++ rocm-hip-devel

COPY build.sh build.sh

# CMD ["bash", "build.sh"]
CMD ["bash"]
