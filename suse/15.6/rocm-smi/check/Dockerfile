FROM registry.suse.com/bci/bci-base:15.6

RUN zypper -n install \
 git \
 rpm-build \
 rpmlint

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/15.6/ rocm
RUN zypper -n si rocm-smi
RUN zypper -n si -d rocm-smi
RUN rpmbuild -ba /usr/src/packages/SPECS/*.spec

RUN rpm -ihv --nodeps /usr/src/packages/RPMS/x86_64/*

CMD ["rocm-smi", "-d", "0", "--showproductname"]
