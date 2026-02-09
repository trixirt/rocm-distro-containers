FROM fedora:f44

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

CMD ["bash"]