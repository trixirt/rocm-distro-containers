FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint \
 wget

# https://bugzilla.redhat.com/show_bug.cgi?id=2383772
RUN wget https://trix.fedorapeople.org/rocm-validation-suite-6.4.2-1.fc43.src.rpm
RUN rpm -i rocm-validation-suite-6.4.2-1.fc43.src.rpm
RUN wget https://trix.fedorapeople.org/rocm-validation-suite.spec
RUN dnf -y builddep rocm-validation-suite.spec
RUN rpmbuild -ba rocm-validation-suite.spec

CMD ["bash"]