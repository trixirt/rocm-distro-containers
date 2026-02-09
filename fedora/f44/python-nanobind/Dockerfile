FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/python-nanobind.git
RUN dnf -y builddep python-nanobind/python-nanobind.spec
RUN spectool -g -R python-nanobind/python-nanobind.spec
RUN cp python-nanobind/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-nanobind/python-nanobind.spec

CMD ["bash"]