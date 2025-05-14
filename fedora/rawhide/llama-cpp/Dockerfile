FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/llama-cpp.git
RUN dnf -y builddep llama-cpp/llama-cpp.spec
RUN spectool -g -R llama-cpp/llama-cpp.spec
RUN cp llama-cpp/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba llama-cpp/llama-cpp.spec

CMD ["bash"]