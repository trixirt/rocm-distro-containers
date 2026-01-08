FROM quay.io/centos/centos:stream10

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools \

RUN dnf config-manager --setopt=repo_id.gpgcheck=0 --add-repo https://download.copr.fedorainfracloud.org/results/@rocm-packagers-sig/EPEL10/epel-10-x86_64/

RUN dnf update --nogpgcheck -y

RUN git clone -b rawhide https://src.fedoraproject.org/rpms/ollama.git
WORKDIR ollama
RUN dnf --nogpgcheck -y builddep ollama.spec
RUN fedpkg srpm
RUN rpm -ihv *.src.rpm
RUN rpmbuild -ba ollama.spec

CMD ["bash"]