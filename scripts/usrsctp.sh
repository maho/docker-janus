#!/usr/bin/env bash
set -e
git clone https://github.com/sctplab/usrsctp.git -b 0.9.3.0 --depth 1 /janus/dl/usrsctp
cd /janus/dl/usrsctp
./bootstrap
./configure --prefix=/janus && make -j4 && make install
