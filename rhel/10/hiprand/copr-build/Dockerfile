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

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/hiprand.git
RUN dnf --nogpgcheck -y builddep hiprand/hiprand.spec
RUN spectool -g -R hiprand/hiprand.spec
RUN cp -r hiprand/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hiprand/hiprand.spec

# Now try to build --with test
# Other test depends
RUN dnf install -y gtest-devel
# Now the build
RUN rpmbuild --with test -ba hiprand/hiprand.spec 2>&1 | tee build.log

COPY check-warnings.sh check-warnings.sh
RUN ./check-warnings.sh build.log 2>&1 | tee warnings.log

CMD ["bash"]