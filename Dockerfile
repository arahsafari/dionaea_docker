FROM ubuntu:latest

ADD /dist /root/dist

# update & upgrade
RUN apt-get update -y && \
    apt-get dist-upgrade -y

# install dependence
RUN apt-get -y --no-install-recommends install \
    build-essential \
    check \
    cmake \
    cython3 \
    libcurl4-openssl-dev \
    libemu-dev \
    libev-dev \
    libglib2.0-dev \
    libloudmouth1-dev \
    libnetfilter-queue-dev \
    libnl-3-dev \
    libpcap-dev \
    libssl-dev \
    libtool \
    libudns-dev \
    python3 \
    python3-dev \
    python3-bson \
    python3-yaml \
    git \
    ca-certificates

# clone repository
RUN git clone https://github.com/DinoTools/dionaea
WORKDIR dionaea

# build setting
RUN mkdir build
WORKDIR build
RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/dionaea ..

# build
RUN make && \
    make install

CMD ["/opt/dionaea/bin/dionaea"]
#CMD ["/opt/dionaea/bin/dionaea", "-u", "dionaea", "-g", "dionaea", "-c", "/opt/dionaea/etc/dionaea/dionaea.cfg"]
