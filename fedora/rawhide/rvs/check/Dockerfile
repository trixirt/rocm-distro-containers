FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint \
 wget

RUN git clone https://src.fedoraproject.org/rpms/rocm-validation-suite.git
RUN dnf -y builddep rocm-validation-suite/rocm-validation-suite.spec
RUN spectool -g -R rocm-validation-suite/rocm-validation-suite.spec
RUN cp -r rocm-validation-suite/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-validation-suite/rocm-validation-suite.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

# CMD ["/usr/bin/rvs", "-c", "/usr/share/rocm-validation-suite/conf/rvs.conf" ]
CMD ["/usr/bin/bash" ]


