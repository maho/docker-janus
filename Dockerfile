FROM ubuntu:14.04

# bootstrap environment
ENV DEPS_HOME="/root/janus"
ENV SCRIPTS_PATH="/tmp/scripts"

# install baseline package dependencies
RUN apt-get -y update && apt-get install -y libmicrohttpd-dev \
  libjansson-dev \
  libnice-dev \
  libssl-dev \
  libsrtp-dev \
  libsofia-sip-ua-dev \
  libglib2.0-dev \
  libopus-dev \
  libogg-dev \
  libini-config-dev \
  libcollection-dev \
  pkg-config \
  gengetopt \
  libtool \
  automake \
  build-essential \
  subversion \
  git \
  cmake \
  wget \
 && rm -rf /var/lib/apt/lists/*

COPY scripts/bootstrap.sh $SCRIPTS_PATH/
RUN $SCRIPTS_PATH/bootstrap.sh

COPY scripts/usrsctp.sh $SCRIPTS_PATH/
RUN $SCRIPTS_PATH/usrsctp.sh

COPY scripts/libwebsockets.sh $SCRIPTS_PATH/
RUN $SCRIPTS_PATH/libwebsockets.sh

ENV JANUS_RELEASE="v0.1.1"
COPY scripts/janus.sh $SCRIPTS_PATH/
RUN $SCRIPTS_PATH/janus.sh

COPY scripts/config.sh $SCRIPTS_PATH/
RUN $SCRIPTS_PATH/config.sh

EXPOSE 8188 8189 6000/udp

CMD ["/root/janus/bin/janus"]
