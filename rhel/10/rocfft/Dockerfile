FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocfft.git
RUN dnf -y builddep rocfft/rocfft.spec
RUN spectool -g -R rocfft/rocfft.spec
RUN cp -r rocfft/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocfft/rocfft.spec

CMD ["bash"]