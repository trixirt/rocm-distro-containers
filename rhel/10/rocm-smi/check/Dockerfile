FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocm-smi.git
RUN dnf -y builddep rocm-smi/rocm-smi.spec
RUN spectool -g -R rocm-smi/rocm-smi.spec
RUN cp -r rocm-smi/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-smi/rocm-smi.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["rocm-smi", "-d", "0", "--showproductname"]