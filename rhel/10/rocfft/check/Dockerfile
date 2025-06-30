FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN dnf install -y \
 rocrand-devel \
 fftw-devel \
 boost-devel \
 hipcc-libomp-devel \
 hiprand-devel \
 gtest-devel

RUN dnf download --source rocfft
RUN rpm -ihv *.rpm
RUN dnf -y builddep ~/rpmbuild/SPECS/*.spec
RUN rpmbuild -ba --with test ~/rpmbuild/SPECS/*.spec

# RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocfft.git
# RUN dnf --nogpgcheck -y builddep rocfft/rocfft.spec
# RUN spectool -g -R rocfft/rocfft.spec
# RUN cp -r rocfft/* ~/rpmbuild/SOURCES
# RUN rpmbuild -ba --with test rocfft/rocfft.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["rocfft-test"]
