FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/FP16.git
RUN dnf -y builddep FP16/FP16.spec
RUN spectool -g -R FP16/FP16.spec
RUN cp FP16/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba FP16/FP16.spec

CMD ["bash"]