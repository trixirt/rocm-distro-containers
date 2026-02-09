FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/fmt.git
RUN dnf -y builddep fmt/fmt.spec
RUN spectool -g -R fmt/fmt.spec
RUN cp fmt/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba fmt/fmt.spec

CMD ["bash"]