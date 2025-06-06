FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si librocsolver0
RUN zypper -n si -d librocsolver0

RUN zypper -n install \
 gcc-fortran \
 gtest \
 blas-devel \
 blas-devel-static \
 lapack-devel-static

RUN rpmbuild -ba --with test ~/rpmbuild/SPECS/*.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["rocsolver-test"]
