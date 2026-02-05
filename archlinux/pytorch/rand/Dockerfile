FROM archlinux:latest

RUN yes | pacman -Syu

RUN yes | pacman -S rocminfo python-pytorch-rocm

COPY test.py test.py

CMD ["python3", "test.py" ]
# CMD ["bash" ]