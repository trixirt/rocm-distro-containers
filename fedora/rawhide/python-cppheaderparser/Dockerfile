FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/python-cppheaderparser.git
RUN dnf -y builddep python-cppheaderparser/python-cppheaderparser.spec
RUN spectool -g -R python-cppheaderparser/python-cppheaderparser.spec
RUN cp python-cppheaderparser/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-cppheaderparser/python-cppheaderparser.spec

CMD ["bash"]