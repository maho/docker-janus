#!/usr/bin/env bash
set -e

# create a self signed cert for the server
mkdir -p $DEPS_HOME/certs/
openssl req \
  -new \
  -newkey rsa:4096 \
  -days 365 \
  -nodes \
  -x509 \
  -subj "/C=AU/ST=NSW/L=Sydney/O=JanusDemo/CN=janus.test.com" \
  -keyout $DEPS_HOME/certs/janus.key \
  -out $DEPS_HOME/certs/janus.pem

wget https://github.com/meetecho/janus-gateway/archive/$JANUS_RELEASE.tar.gz -O  $DEPS_HOME/dl/janus.tar.gz

cd $DEPS_HOME/dl
tar xf janus.tar.gz
cd janus*
./autogen.sh

./configure --prefix=$DEPS_HOME --enable-websockets --disable-rabbitmq --disable-docs
make
make install
