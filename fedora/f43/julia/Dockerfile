FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint \
 which

RUN git clone https://src.fedoraproject.org/rpms/julia.git
RUN dnf -y builddep julia/julia.spec
RUN spectool -g -R julia/julia.spec
RUN cp -r julia/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba julia/julia.spec

CMD ["bash"]