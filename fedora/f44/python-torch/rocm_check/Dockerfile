FROM fedora:f44

RUN dnf update -y

RUN dnf install -y rocminfo python3-torch

COPY test_rocm.py test_rocm.py

CMD ["python3", "test_rocm.py" ]