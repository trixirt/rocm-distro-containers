FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/hipcub.git
RUN dnf -y builddep hipcub/hipcub.spec
RUN spectool -g -R hipcub/hipcub.spec
RUN cp -r hipcub/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipcub/hipcub.spec

CMD ["bash"]