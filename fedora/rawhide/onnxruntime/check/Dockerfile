FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/onnxruntime.git
RUN dnf -y builddep onnxruntime/onnxruntime.spec
RUN spectool -g -R onnxruntime/onnxruntime.spec
RUN cp -r onnxruntime/* ~/rpmbuild/SOURCES

CMD ["rpmbuild", "-ba", "--with", "check", "--with", "rocm_test", "onnxruntime/onnxruntime.spec"]