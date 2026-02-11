FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 gcc-c++ \
 git \
 rocm-hip-devel \
 rocminfo \
 hipcub-devel

RUN git clone https://src.fedoraproject.org/rpms/hipcub.git
WORKDIR ./hipcub

CMD ["bash", "test.sh"]
# CMD ["bash"]

