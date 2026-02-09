FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/heffte.git
RUN dnf -y builddep heffte/heffte.spec
RUN spectool -g -R heffte/heffte.spec
RUN cp heffte/* ~/rpmbuild/SOURCES

# Running has this error
# 0.515 + test -n mpich
# 0.515 + module load mpi/mpich-x86_64
# 0.515 /var/tmp/rpm-tmp.JG2Vv0: line 54: module: command not found
#
# RUN rpmbuild -ba heffte/heffte.spec
#
# Need to run the command manually
CMD ["bash"]

