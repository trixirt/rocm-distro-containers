FROM fedora:f44

RUN dnf update -y

RUN dnf install -y git python3-devel python3-setuptools python3-build

RUN git clone -b f44 https://git.kernel.org/pub/scm/linux/kernel/git/superm1/amd-debug-tools.git
RUN cd amd-debug-tools; python3 -m build

CMD ["bash"]