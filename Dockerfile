FROM ubuntu:xenial
MAINTAINER Feiyu Du <fdu@wustl.edu>

LABEL \
  version="v0.2.5b8" \
  description="Pindel image for use in Workflows"

RUN apt-get update && apt-get install -y \
  bzip2 \
  wget \
  make \
  ncurses-dev \
  zlib1g-dev \
  g++

WORKDIR /opt
RUN wget https://github.com/samtools/samtools/releases/download/1.2/samtools-1.2.tar.bz2 && \
  tar xvjf samtools-1.2.tar.bz2

WORKDIR /opt/samtools-1.2
RUN make && make install

WORKDIR /opt
RUN wget https://github.com/genome/pindel/archive/v0.2.5b8.tar.gz && \
  tar -xzf v0.2.5b8.tar.gz

WORKDIR /opt/pindel-0.2.5b8
RUN ./INSTALL /opt/samtools-1.2/htslib-1.2.1

WORKDIR /
RUN ln -s /opt/pindel-0.2.5b8/pindel /usr/bin/pindel

ENTRYPOINT ["/usr/bin/pindel"]
