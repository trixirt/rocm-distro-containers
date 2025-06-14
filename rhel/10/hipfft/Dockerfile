FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/hipfft.git
RUN dnf -y builddep hipfft/hipfft.spec
RUN spectool -g -R hipfft/hipfft.spec
RUN cp -r hipfft/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipfft/hipfft.spec

CMD ["bash"]