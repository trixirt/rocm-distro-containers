FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y pytorch-examples python3-sympy

WORKDIR /usr/share/pytorch-examples/vae

CMD ["python3", "main.py"]