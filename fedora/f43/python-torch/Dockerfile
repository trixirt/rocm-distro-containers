FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/python-torch.git
RUN dnf -y builddep python-torch/python-torch.spec
RUN spectool -g -R python-torch/python-torch.spec
RUN cp python-torch/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-torch/python-torch.spec

CMD ["bash"]