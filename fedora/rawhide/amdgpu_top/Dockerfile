FROM fedora:rawhide

RUN dnf update -y
RUN dnf install -y fedora-review wget

# https://bugzilla.redhat.com/show_bug.cgi?id=2453438
RUN wget https://download.copr.fedorainfracloud.org/results/kmarinos/amdgpu_top/fedora-rawhide-x86_64/10427719-amdgpu_top/amdgpu_top.spec
RUN wget https://download.copr.fedorainfracloud.org/results/kmarinos/amdgpu_top/fedora-rawhide-x86_64/10427719-amdgpu_top/amdgpu_top-0.11.4-1.fc45.src.rpm

RUN rpm -ihv amdgpu_top-0.11.4-1.fc45.src.rpm
RUN dnf builddep -y  amdgpu_top.spec
RUN rpmbuild -ba  amdgpu_top.spec

RUN dnf install -y ~/rpmbuild/RPMS/x86_64/*.x86_64.rpm

CMD ["bash"]