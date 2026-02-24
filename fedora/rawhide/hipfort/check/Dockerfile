FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipfort.git
RUN dnf -y builddep hipfort/hipfort.spec
RUN spectool -g -R hipfort/hipfort.spec
RUN cp hipfort/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipfort/hipfort.spec

# Need rocminfo
RUN dnf install -y rocminfo
RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/hipfort*

CMD ["rpmbuild", "-ba", "--with", "check", "hipfort/hipfort.spec" ]
# CMD ["bash" ]