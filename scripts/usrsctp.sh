#!/usr/bin/env bash
git clone https://github.com/sctplab/usrsctp.git -b 0.9.3.0 $DEPS_HOME/dl/usrsctp
cd $DEPS_HOME/dl/usrsctp
./bootstrap
./configure --prefix=$DEPS_HOME && make && make install
