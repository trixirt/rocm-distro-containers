FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipcub.git
RUN dnf -y builddep hipcub/hipcub.spec
RUN spectool -g -R hipcub/hipcub.spec
RUN cp hipcub/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipcub/hipcub.spec

CMD ["bash"]