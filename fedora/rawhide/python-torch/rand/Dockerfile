FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y rocminfo python3-torch

COPY test.py test.py

CMD ["python3", "test.py" ]