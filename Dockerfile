# FROM postgres:latest
FROM --platform=linux/amd64 ubuntu:latest

USER root

# LIBPOSTAL
# Install Libpostal dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install -y \
  autoconf \
  automake \
  curl \
  git \
  libtool \
  pkg-config \
  python3-pip

# Download libpostal source to /usr/local/libpostal
RUN cd /usr/local && git clone https://github.com/openvenues/libpostal

# Create Libpostal data directory at /var/libpostal/data
RUN mkdir -p /var/libpostal/data

# Install Libpostal from source
RUN cd /usr/local/libpostal \
  && ./bootstrap.sh \
  && ./configure --datadir=/var/libpostal/data \
  && make -j4 \
  && make install \
  && ldconfig

# Install Libpostal python Bindings
RUN pip3 install postal
