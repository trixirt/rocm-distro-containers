FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

# EPEL10 copr, where in-development build it
RUN dnf config-manager --setopt=repo_id.gpgcheck=0 --add-repo https://download.copr.fedorainfracloud.org/results/@rocm-packagers-sig/EPEL10/epel-10-x86_64/

RUN dnf update --nogpgcheck -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/hipsparse.git
RUN dnf --nogpgcheck -y builddep hipsparse/hipsparse.spec
RUN spectool -g -R hipsparse/hipsparse.spec
RUN cp -r hipsparse/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipsparse/hipsparse.spec

# Now try to build --with test
RUN dnf --nogpgcheck install -y gtest-devel libomp-devel rocblas-devel
RUN rpmbuild --with test -ba hipsparse/hipsparse.spec

CMD ["bash"]