FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/fplus.git
RUN dnf -y builddep fplus/fplus.spec
RUN spectool -g -R fplus/fplus.spec
RUN cp fplus/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba fplus/fplus.spec

CMD ["bash"]