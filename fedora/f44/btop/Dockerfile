FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/btop.git
RUN dnf -y builddep btop/btop.spec
RUN spectool -g -R btop/btop.spec
RUN cp btop/* ~/rpmbuild/SOURCES

RUN rpmbuild -ba btop/btop.spec

CMD ["bash"]

