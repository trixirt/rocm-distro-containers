FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 git-lfs \
 rpmbuild \
 rpmdevtools \
 rpmlint \
 gcc-fortran \
 gtest \
 blas-devel \
 blas-devel-static \
 lapack-devel \
 lapack-devel-static


RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d librocsolver0
RUN git clone https://src.opensuse.org/ROCm/rocsolver.git
RUN cd rocsolver; git lfs pull
RUN cp -r rocsolver/* ~/rpmbuild/SOURCES

RUN ln -sf /usr/lib64/libblas.so /usr/lib64/libblas.so.3.12.1 && \
    ln -sf /usr/lib64/liblapack.so /usr/lib64/liblapack.so.3.12.1 && \
    ln -sf /usr/lib64/liblapack.so /usr/lib64/libtmglib.so.3.12.1

RUN cd rocsolver; rpmbuild -ba --with test rocsolver.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["rocsolver-test"]
