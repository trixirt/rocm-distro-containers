FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si librocblas4
RUN zypper -n si -d librocblas4

RUN zypper -n install \
 blas-devel \
 libomp-devel \
 python311-PyYAML \
 python312-PyYAML \
 python313-PyYAML \
 rocminfo \
 rocm-smi-devel \
 roctracer-devel \
 cblas-devel \
 gcc-fortran \
 gtest

RUN rpmbuild -ba --with test ~/rpmbuild/SPECS/*.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["rocblas-test"]