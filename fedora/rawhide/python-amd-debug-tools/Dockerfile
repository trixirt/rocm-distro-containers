FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint \
 wget
 
# https://bugzilla.redhat.com/show_bug.cgi?id=2404638
RUN wget https://trix.fedorapeople.org/python-amd-debug-tools-0.2.8-1.fc44.src.rpm
RUN rpm -i https://trix.fedorapeople.org/python-amd-debug-tools-0.2.8-1.fc44.src.rpm
RUN wget https://trix.fedorapeople.org/python-amd-debug-tools.spec
RUN dnf -y builddep python-amd-debug-tools.spec
RUN rpmbuild -ba python-amd-debug-tools.spec

CMD ["bash"]