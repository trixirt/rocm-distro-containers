FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y pytorch-examples python3-sympy

CMD ["python3", "/usr/share/pytorch-examples/mnist/main.py"]