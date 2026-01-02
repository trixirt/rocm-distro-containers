FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 rpmbuild \
 rpmdevtools \
 rpmlint

# To get the build dependencies
RUN rpmdev-setuptree
RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si amdsmi
RUN zypper -n si -d amdsmi

RUN git clone https://github.com/ROCm/amdsmi.git
WORKDIR /amdsmi
RUN mkdir build
WORKDIR /amdsmi/build
RUN cmake -DBUILD_TESTS=ON ..
RUN make

CMD ["bash"]