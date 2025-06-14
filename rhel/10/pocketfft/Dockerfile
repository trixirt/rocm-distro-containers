FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/pocketfft.git
RUN dnf -y builddep pocketfft/pocketfft.spec
RUN spectool -g -R pocketfft/pocketfft.spec
RUN cp -r pocketfft/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba pocketfft/pocketfft.spec

CMD ["bash"]