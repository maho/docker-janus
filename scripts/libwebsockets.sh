#!/usr/bin/env bash
git clone https://github.com/warmcat/libwebsockets.git -b v1.5-chrome47-firefox41 $DEPS_HOME/dl/libwebsockets
cd $DEPS_HOME/dl/libwebsockets
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$DEPS_HOME -DCMAKE_C_FLAGS="-fpic" ..
make && make install
