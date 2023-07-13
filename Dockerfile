RUN apt-get update
RUN apt-get -y install flex bison
RUN apt-get -y install default-jdk
RUN apt-get -y install python3 python3-pip
RUN apt-get -y install wget autoconf libtool
RUN apt-get -y install dotnet-sdk-6.0
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
RUN mkdir -p /spyro
WORKDIR /spyro
RUN apt-get -y install git
RUN git clone https://github.com/ebmoon/spyro.git
RUN git clone https://github.com/ebmoon/spyro-sygus.git
WORKDIR /spyro/spyro
RUN git checkout oopsla23
WORKDIR /spyro/spyro-sygus
RUN git checkout oopsla23-artifact
CMD /bin/bash