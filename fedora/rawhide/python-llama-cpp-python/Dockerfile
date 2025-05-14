FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/python-llama-cpp-python.git
RUN dnf -y builddep python-llama-cpp-python/python-llama-cpp-python.spec
RUN spectool -g -R python-llama-cpp-python/python-llama-cpp-python.spec
RUN cp python-llama-cpp-python/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-llama-cpp-python/python-llama-cpp-python.spec

CMD ["bash"]