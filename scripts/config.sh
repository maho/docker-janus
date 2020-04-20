#!/usr/bin/env bash

cat << EOF > $DEPS_HOME/etc/janus/janus.cfg
[general]
configs_folder = $DEPS_HOME/etc/janus
plugins_folder = $DEPS_HOME/lib/janus/plugins
debug_level = 4

[nat]
stun_server = stun.l.google.com
stun_port = 19302

[certificates]
cert_pem = $DEPS_HOME/certs/janus.pem
cert_key = $DEPS_HOME/certs/janus.key
EOF

cat << EOF > $DEPS_HOME/etc/janus/janus.transport.http.cfg
[general]
base_path = /janus
threads = unlimited
http = yes
port = 8188
https = no

[certificates]
cert_pem = $DEPS_HOME/certs/janus.pem
cert_key = $DEPS_HOME/certs/janus.key
EOF

cat << EOF > $DEPS_HOME/etc/janus/janus.transport.websockets.cfg
[general]
ws = yes
ws_port = 8189
wss = no

[certificates]
cert_pem = $DEPS_HOME/certs/janus.pem
cert_key = $DEPS_HOME/certs/janus.key
EOF

cat << EOF > $DEPS_HOME/etc/janus/janus.plugin.streaming.cfg
[stream1]
type = rtp
id = 1
description = stream1
audio = no
video = yes
videoport = 6000
videopt = 96
videortpmap = VP8/90000
[stream2]
type = rtp
id = 2
description = stream2
audio = no
video = yes
videoport = 6001
videopt = 96
videortpmap = VP8/90000
[stream3]
type = rtp
id = 3
description = stream3
audio = no
video = yes
videoport = 6002
videopt = 96
videortpmap = VP8/90000
EOF
