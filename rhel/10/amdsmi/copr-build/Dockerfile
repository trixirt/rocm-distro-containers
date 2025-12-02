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

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/amdsmi.git
RUN dnf --nogpgcheck -y builddep amdsmi/amdsmi.spec
RUN spectool -g -R amdsmi/amdsmi.spec
RUN cp -r amdsmi/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba amdsmi/amdsmi.spec

# Now try to build --with test
RUN dnf install -y gtest-devel
RUN rpmbuild --with test -ba amdsmi/amdsmi.spec

CMD ["bash"]