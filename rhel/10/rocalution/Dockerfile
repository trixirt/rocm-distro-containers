FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocalution.git
RUN dnf -y builddep rocalution/rocalution.spec
RUN spectool -g -R rocalution/rocalution.spec
RUN cp -r rocalution/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocalution/rocalution.spec

CMD ["bash"]