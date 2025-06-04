FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si librocfft0
RUN zypper -n si -d librocfft0

RUN zypper -n install \
 rocrand-devel \
 fftw-devel \
 boost-devel \
 hipcc-libomp-devel \
 hiprand-devel \
 gtest

RUN rpmbuild --with test -ba ~/rpmbuild/SPECS/*.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["rocfft-test"]