FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/frugally-deep.git
RUN dnf -y builddep frugally-deep/frugally-deep.spec
RUN spectool -g -R frugally-deep/frugally-deep.spec
RUN cp frugally-deep/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba frugally-deep/frugally-deep.spec

CMD ["bash"]