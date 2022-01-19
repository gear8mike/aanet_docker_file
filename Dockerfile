FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install wget python3-pip git -y 

RUN pip3 install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab

#ROOT required packages
RUN apt-get install dpkg-dev cmake g++ gcc binutils libx11-dev \ 
    libxpm-dev libxft-dev libxext-dev python libssl-dev -y
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
#RUN ["/bin/bash", "-c", "source /root/bin/thisroot.sh"]

ENV ROOTSYS="/root"
ENV LD_LIBRARY_PATH="${ROOTSYS}/lib:${LD_LIBRARY_PATH}"
ENV PYTHONPATH="${ROOTSYS}/lib:${PYTHONPATH}"

COPY aanet-master.tar.gz .
RUN tar -xvf aanet-master.tar.gz && \
    rm -rf aanet-master.tar.gz

#RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN cd aanet-master && \
    ["/bin/bash", "-c", "source /aanet-master/setenv.sh && ./aanet-master/make.py"]
#RUN ["/bin/bash", "-c", "source /aanet-master/setenv.sh"]
#RUN ["/bin/bash", "-c", "./aanet-master/make.py"]
