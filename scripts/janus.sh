#!/usr/bin/env bash
set -e

# create a self signed cert for the server
mkdir -p /janus/certs/
openssl req \
  -new \
  -newkey rsa:4096 \
  -days 365 \
  -nodes \
  -x509 \
  -subj "/C=AU/ST=NSW/L=Sydney/O=JanusDemo/CN=janus.test.com" \
  -keyout /janus/certs/janus.key \
  -out /janus/certs/janus.pem

wget https://github.com/meetecho/janus-gateway/archive/$JANUS_RELEASE.tar.gz -O  /janus/dl/janus.tar.gz

cd /janus/dl
tar xf janus.tar.gz
cd janus-gateway-*
./autogen.sh

./configure --prefix=/janus --enable-websockets --disable-rabbitmq --disable-mqtt --disable-data-channels --disable-docs
export PKG_CONFIG_PATH="/janus"
make
make install
