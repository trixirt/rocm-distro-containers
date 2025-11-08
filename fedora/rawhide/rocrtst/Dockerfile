FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint \
 wget
 
# https://bugzilla.redhat.com/show_bug.cgi?id=2413365
RUN wget https://mystro256.fedorapeople.org/rocrtst-7.1.0-1.fc44.src.rpm
RUN rpm -i rocrtst-7.1.0-1.fc44.src.rpm
RUN wget https://mystro256.fedorapeople.org/rocrtst.spec
RUN dnf -y builddep rocrtst.spec
RUN rpmbuild -ba rocrtst.spec

CMD ["bash"]