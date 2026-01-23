FROM archlinux:latest

RUN yes | pacman -Syu

RUN yes | pacman -S rocminfo python-pytorch-rocm

COPY test_rocm.py test_rocm.py

CMD ["python3", "test_rocm.py" ]
# CMD ["bash" ]