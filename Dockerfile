FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y
RUN apt-get install wget -y   

#ROOT required packages
RUN apt-get install dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev python libssl-dev -y
#ROOT other packages
RUN apt-get install gfortran libpcre3-dev \
    xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    graphviz-dev libavahi-compat-libdnssd-dev \
    libldap2-dev python-dev libxml2-dev libkrb5-dev \
    libgsl0-dev -y
#ROOT installation
RUN wget https://root.cern/download/root_v6.24.02.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    tar -xzvf root_v6.24.02.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    rm -rf root_v6.24.02.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    echo "source root/bin/thisroot.sh" >> ~/.bashrc