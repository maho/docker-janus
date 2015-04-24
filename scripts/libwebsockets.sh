#!/usr/bin/env bash
set -e
git clone https://github.com/warmcat/libwebsockets.git -b v2.4-stable --depth 1 /janus/dl/libwebsockets
cd /janus/dl/libwebsockets
mkdir build
cd build
cmake -DLWS_MAX_SMP=1 -DCMAKE_INSTALL_PREFIX=/janus -DCMAKE_C_FLAGS="-fpic" ..
make -j4 && make install
