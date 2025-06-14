FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/FP16.git
RUN dnf -y builddep FP16/FP16.spec
RUN spectool -g -R FP16/FP16.spec
RUN cp -r FP16/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba FP16/FP16.spec

CMD ["bash"]