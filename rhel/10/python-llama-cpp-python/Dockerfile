FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/python-llama-cpp-python.git
RUN dnf -y builddep python-llama-cpp-python/python-llama-cpp-python.spec
RUN spectool -g -R python-llama-cpp-python/python-llama-cpp-python.spec
RUN cp -r python-llama-cpp-python/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-llama-cpp-python/python-llama-cpp-python.spec

CMD ["bash"]