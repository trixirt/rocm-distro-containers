FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/composable_kernel.git
RUN dnf -y builddep composable_kernel/composable_kernel.spec
RUN spectool -g -R composable_kernel/composable_kernel.spec
RUN cp -r composable_kernel/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba composable_kernel/composable_kernel.spec

CMD ["bash"]