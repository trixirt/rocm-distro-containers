FROM fedora:rawhide

RUN dnf update -y
RUN dnf install -y fedora-review wget

# https://bugzilla.redhat.com/show_bug.cgi?id=2453414
RUN wget https://download.copr.fedorainfracloud.org/results/kmarinos/lemonade-server/srpm-builds/10460803/lemonade-server.spec
RUN wget https://download.copr.fedorainfracloud.org/results/kmarinos/lemonade-server/srpm-builds/10460803/lemonade-server-10.4.0-1.fc45.src.rpm

RUN rpm -ihv lemonade-server-10.4.0-1.fc45.src.rpm
RUN dnf builddep -y --with check lemonade-server.spec
RUN rpmbuild -ba --with check lemonade-server.spec

RUN dnf install -y ~/rpmbuild/RPMS/x86_64/lemonade-server-10.4.0-1.fc45.x86_64.rpm

CMD ["bash"]