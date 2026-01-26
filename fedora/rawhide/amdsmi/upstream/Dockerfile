FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

# To get the 
RUN dnf -y builddep amdsmi

RUN git clone https://github.com/ROCm/amdsmi.git

COPY build.sh build.sh

CMD ["bash", "build.sh"]