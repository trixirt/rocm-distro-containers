FROM registry.suse.com/bci/bci-base:15.6

RUN zypper -n install \
 git \
 rpm-build \
 rpmlint

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/15.6/ rocm
RUN zypper -n si librccl1
RUN zypper -n si -d librccl1
RUN rpmbuild -ba /usr/src/packages/SPECS/*.spec

CMD ["bash"]