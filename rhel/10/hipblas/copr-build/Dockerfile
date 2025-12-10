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

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/hipblas.git
RUN dnf --nogpgcheck -y builddep hipblas/hipblas.spec
RUN spectool -g -R hipblas/hipblas.spec
RUN cp -r hipblas/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipblas/hipblas.spec

# Now try to build --with test
#
# Need static version of blas
RUN git clone -b c10s https://gitlab.com/redhat/centos-stream/rpms/lapack.git
RUN dnf --nogpgcheck -y builddep lapack/lapack.spec
RUN spectool -g -R lapack/lapack.spec
RUN cp -r lapack/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba lapack/lapack.spec
RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*
# Other test depends
RUN dnf install -y gtest-devel python3-pyyaml
# Now the build
RUN rpmbuild --with test -ba hipblas/hipblas.spec 2>&1 | tee build.log

COPY check-warnings.sh check-warnings.sh
RUN ./check-warnings.sh build.log 2>&1 | tee warnings.log

CMD ["bash"]