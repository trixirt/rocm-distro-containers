FROM ubuntu:25.04

CMD apt-update
CMD apt install adduser apt-file emacs git openssh-server build-essential cmake ninja-build apt-file python3 ccache

CMD apt-file update
CMD ccache -M 64G

CMD service ssh restart
CMD ["bash"]