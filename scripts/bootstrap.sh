#!/usr/bin/env bash

# dependency locations (no sudo required)
mkdir -p /janus/dl
mkdir -p /janus/share

cat << EOF > /janus/share/config.site
CPPFLAGS=-I/janus/include
LDFLAGS=-L/janus/lib
EOF
