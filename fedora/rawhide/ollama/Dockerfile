FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 fedpkg \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/ollama.git
RUN dnf -y builddep ollama/ollama.spec
RUN cd ollama; fedpkg srpm
RUN rpm -ihv --nosignature ollama/*.src.rpm
RUN rpmbuild -ba ollama/ollama.spec

CMD ["bash"]