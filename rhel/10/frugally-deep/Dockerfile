FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/frugally-deep.git
RUN dnf -y builddep frugally-deep/frugally-deep.spec
RUN spectool -g -R frugally-deep/frugally-deep.spec
RUN cp -r frugally-deep/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba frugally-deep/frugally-deep.spec

CMD ["bash"]