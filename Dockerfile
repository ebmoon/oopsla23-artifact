FROM ubuntu:22.04
RUN apt-get update
RUN apt-get -y install flex bison
RUN apt-get -y install default-jdk
RUN apt-get -y install python3 python3-pip
RUN apt-get -y install wget autoconf libtool
RUN apt-get -y install dotnet-sdk-6.0
RUN apt-get -y install unzip
RUN pip install --upgrade pip
RUN pip install z3-solver
RUN pip install cvc5
RUN pip install numpy
RUN pip install matplotlib
WORKDIR /
RUN wget https://people.csail.mit.edu/asolar/sketch-1.7.6.tar.gz
RUN wget https://github.com/dafny-lang/dafny/releases/download/v4.1.0/dafny-4.1.0-x64-ubuntu-20.04.zip
RUN tar -xvf sketch-1.7.6.tar.gz
RUN unzip dafny-4.1.0-x64-ubuntu-20.04.zip
WORKDIR /sketch-1.7.6/sketch-backend
RUN ./autogen.sh
RUN ./configure
RUN make
ENV PATH="$PATH:/sketch-1.7.6/sketch-frontend"
RUN apt-get -y install git
WORKDIR /
RUN git clone --recursive https://github.com/ebmoon/oopsla23-artifact.git
WORKDIR /oopsla23-artifact
CMD /bin/bash
