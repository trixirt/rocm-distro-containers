FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/hipfft.git
RUN dnf -y builddep hipfft/hipfft.spec
RUN spectool -g -R hipfft/hipfft.spec
RUN cp hipfft/* ~/rpmbuild/SOURCES

RUN dnf install -y \
 boost-devel \
 fftw-devel \
 hiprand-devel \
 rocrand-devel \
 gtest-devel

RUN rpmbuild -ba --with test hipfft/hipfft.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["hipfft-test"]
