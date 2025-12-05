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

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocthrust.git
RUN dnf --nogpgcheck -y builddep rocthrust/rocthrust.spec
RUN spectool -g -R rocthrust/rocthrust.spec
RUN cp -r rocthrust/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocthrust/rocthrust.spec

# Now try to build --with check
RUN dnf --nogpgcheck install -y gtest-devel rocminfo
# RUN rpmbuild --with check -ba rocthrust/rocthrust.spec

CMD ["bash"]