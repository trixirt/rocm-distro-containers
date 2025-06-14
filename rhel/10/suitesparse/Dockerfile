FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/suitesparse.git
RUN dnf -y builddep suitesparse/suitesparse.spec
RUN spectool -g -R suitesparse/suitesparse.spec
RUN cp -r suitesparse/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba suitesparse/suitesparse.spec

CMD ["bash"]