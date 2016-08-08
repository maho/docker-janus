#!/usr/bin/env bash
set -e
git clone https://github.com/warmcat/libwebsockets.git -b v2.0.2 --depth 1 $DEPS_HOME/dl/libwebsockets
cd $DEPS_HOME/dl/libwebsockets
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$DEPS_HOME -DCMAKE_C_FLAGS="-fpic" ..
make -j4 && make install
