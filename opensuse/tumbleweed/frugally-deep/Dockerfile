FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si frugally-deep
RUN zypper -n si -d frugally-deep
RUN rpmbuild -ba ~/rpmbuild/SPECS/*.spec

CMD ["bash"]