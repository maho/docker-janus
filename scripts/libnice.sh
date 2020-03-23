#!/usr/bin/env bash
set -e
git clone https://gitlab.freedesktop.org/libnice/libnice -b 0.1.16 --depth=1 $DEPS_HOME/dl/libnice
cd $DEPS_HOME/dl/libnice
./autogen.sh
./configure --prefix=/usr
make -j4 && make install
