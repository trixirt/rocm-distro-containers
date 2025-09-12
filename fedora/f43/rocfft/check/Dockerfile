FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocfft.git
RUN dnf -y builddep rocfft/rocfft.spec
RUN spectool -g -R rocfft/rocfft.spec
RUN cp rocfft/* ~/rpmbuild/SOURCES

RUN dnf install -y \
 rocrand-devel \
 fftw-devel \
 boost-devel \
 hipcc-libomp-devel \
 hiprand-devel \
 gtest-devel

RUN rpmbuild -ba --with test rocfft/rocfft.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["rocfft-test"]