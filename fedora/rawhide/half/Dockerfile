FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/half.git
RUN dnf -y builddep half/half.spec
RUN spectool -g -R half/half.spec
RUN cp half/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba half/half.spec

CMD ["bash"]