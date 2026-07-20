FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 git \
 ninja-build \
 python3-yaml \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo \
 time

# for tests
RUN dnf install -y \
 nodejs22-npm \
 python3-jinja2

RUN dnf -y builddep llama-cpp
RUN git clone https://github.com/ggerganov/llama.cpp

COPY build.sh build.sh

CMD ["bash", "build.sh"]
# CMD ["bash"]
