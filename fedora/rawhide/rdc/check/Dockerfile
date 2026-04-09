FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint \
 wget

RUN git clone https://src.fedoraproject.org/rpms/rocm-rdc.git
RUN dnf -y builddep --with test rocm-rdc/rocm-rdc.spec
RUN spectool -g -R rocm-rdc/rocm-rdc.spec
RUN cp rocm-rdc/* ~/rpmbuild/SOURCES
# Need to install the samples first
RUN rpmbuild -ba rocm-rdc/rocm-rdc.spec
RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/*

# CMD ["/usr/bin/rdcd", "-u"]

RUN cp /usr/libexec/rdc/rdc.service /etc/systemd/system/

COPY test.sh /usr/local/bin/

CMD ["/usr/local/bin/test.sh"]

