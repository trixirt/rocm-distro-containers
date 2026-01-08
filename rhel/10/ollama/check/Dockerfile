FROM quay.io/centos/centos:stream10

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools \
 fedpkg

RUN dnf update --nogpgcheck -y

RUN git clone -b rawhide https://src.fedoraproject.org/rpms/ollama.git
WORKDIR /ollama
RUN dnf --nogpgcheck -y builddep ollama.spec
RUN fedpkg srpm
RUN rpm -ihv *.src.rpm
RUN rpmbuild -ba ollama.spec
RUN rpm -ihv ~/rpmbuild/RPMS/x86_64/*

WORKDIR /

RUN dnf install -y pip
RUN pip install open-webui

COPY serve.sh /
CMD ["bash", "-c", "./serve.sh" ]
