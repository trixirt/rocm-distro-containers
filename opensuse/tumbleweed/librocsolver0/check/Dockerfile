FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 git-lfs \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d librocsolver0

RUN zypper -n install \
 gcc-fortran \
 gtest \
 blas-devel \
 blas-devel-static \
 lapack-devel-static

RUN git clone https://src.opensuse.org/ROCm/rocsolver.git
RUN cd rocsolver; git lfs pull
RUN cp -r rocsolver/* ~/rpmbuild/SOURCES
RUN cd rocsolver; rpmbuild -ba --with test rocsolver.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["rocsolver-test"]
