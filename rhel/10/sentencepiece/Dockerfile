FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/sentencepiece.git
RUN dnf -y builddep sentencepiece/sentencepiece.spec
RUN spectool -g -R sentencepiece/sentencepiece.spec
RUN cp -r sentencepiece/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba sentencepiece/sentencepiece.spec

CMD ["bash"]