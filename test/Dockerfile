FROM ubuntu:20.04

RUN apt-get update && apt-get install -y sudo
RUN adduser --disabled-password --home /home/radekdocker --gecos '' radekdocker
RUN adduser radekdocker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER radekdocker

WORKDIR /work

CMD ["/bin/bash"]

