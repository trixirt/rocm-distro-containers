FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 python3-torchvision \
 python3-transformers \
 rocminfo

COPY test.py test.py
CMD ["python3", "test.py" ]

# CMD ["bash" ]