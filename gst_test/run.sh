#!/bin/sh

WIDTH=320
HEIGHT=240
BITRATE=1024000
SERVER=${JANUS_SERVER:-localhost}
VIDEO_DEVICE=${VIDEO_DEVICE:-/dev/video0}

gst-launch-1.0 -v v4l2src device=/dev/video0  \
! capsfilter caps=video/x-raw,width=$WIDTH,height=$HEIGHT \
! videoconvert \
! timeoverlay \
! queue \
! vp8enc deadline=33333 cpu-used=16 target-bitrate=$BITRATE keyframe-max-dist=90 max-quantizer=24 \
! rtpvp8pay \
! udpsink host=$SERVER port=6000 sync=false qos=true
