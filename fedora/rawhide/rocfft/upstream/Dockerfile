FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 git \
 ninja-build \
 python3-yaml \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo \
 time \
 rocrand-devel \
 fftw-devel \
 boost-devel \
 hiprand-devel \
 gtest-devel
 

RUN dnf -y builddep rocfft
RUN git clone https://github.com/ROCm/rocm-libraries

COPY build.sh build.sh

CMD ["bash", "build.sh"]
# CMD ["bash"]
