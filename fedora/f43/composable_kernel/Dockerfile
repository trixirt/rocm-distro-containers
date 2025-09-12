FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint \
 wget

# https://bugzilla.redhat.com/show_bug.cgi?id=2336118
RUN wget https://trix.fedorapeople.org/composable_kernel-6.4.2-1.fc43.src.rpm
RUN rpm -i composable_kernel-6.4.2-1.fc43.src.rpm
RUN wget https://trix.fedorapeople.org/composable_kernel.spec
RUN dnf -y builddep composable_kernel.spec
RUN rpmbuild -ba composable_kernel.spec

CMD ["bash"]