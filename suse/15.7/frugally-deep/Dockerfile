FROM registry.suse.com/bci/bci-base:15.7

RUN zypper -n install \
 git \
 rpm-build \
 rpmlint

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/Backports_SLE-15-SP7/ rocm
RUN zypper -n si frugally-deep
RUN zypper -n si -d frugally-deep
RUN rpmbuild -ba /usr/src/packages/SPECS/*.spec

CMD ["bash"]