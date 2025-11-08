FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint \
 wget
 
RUN wget https://trix.fedorapeople.org/rocm-rdc-7.1.0-1.fc44.src.rpm
RUN rpm -i rocm-rdc-7.1.0-1.fc44.src.rpm
RUN wget https://trix.fedorapeople.org/rocm-rdc.spec
RUN dnf -y builddep rocm-rdc.spec
RUN rpmbuild -ba rocm-rdc.spec

RUN dnf install -y ~/rpmbuild/RPMS/x86_64/*

# CMD ["/usr/bin/rdcd", "-u"]

RUN cp /usr/libexec/rdc/rdc.service /etc/systemd/system/

COPY test.sh /usr/local/bin/

CMD ["/usr/local/bin/test.sh"]

