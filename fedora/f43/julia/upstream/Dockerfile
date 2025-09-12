FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 git \
 not \
 wget \
 which

RUN dnf -y builddep julia

RUN git clone https://github.com/JuliaLang/julia.git
WORKDIR julia

CMD ["bash"]