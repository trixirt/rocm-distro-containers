FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocalution.git
RUN dnf -y builddep rocalution/rocalution.spec
RUN spectool -g -R rocalution/rocalution.spec
RUN cp rocalution/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocalution/rocalution.spec

CMD ["bash"]