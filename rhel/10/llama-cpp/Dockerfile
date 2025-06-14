FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/llama-cpp.git
RUN dnf -y builddep llama-cpp/llama-cpp.spec
RUN spectool -g -R llama-cpp/llama-cpp.spec
RUN cp -r llama-cpp/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba llama-cpp/llama-cpp.spec

CMD ["bash"]