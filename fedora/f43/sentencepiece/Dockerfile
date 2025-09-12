FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/sentencepiece.git
RUN dnf -y builddep sentencepiece/sentencepiece.spec
RUN spectool -g -R sentencepiece/sentencepiece.spec
RUN cp sentencepiece/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba sentencepiece/sentencepiece.spec

CMD ["bash"]