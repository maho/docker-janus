#!/bin/sh

WIDTH=320
HEIGHT=240
SERVER=${JANUS_SERVER:-localhost}
VIDEO_DEVICE=${VIDEO_DEVICE:-/dev/video0}


gst-launch-1.0 \
    alsasrc device=plughw:2,0 ! \
      audioresample ! audio/x-raw,channels=1,rate=16000 ! \
      opusenc bitrate=20000 ! \
        rtpopuspay ! udpsink host=$SERVER port=5002 \
    \
    v4l2src device=/dev/video0 ! \
    video/x-raw,width=$WIDTH,height=$HEIGHT,framerate=15/1 ! \
    videoscale ! videorate ! videoconvert ! timeoverlay ! \
    vp8enc error-resilient=1 ! \
      rtpvp8pay ! udpsink host=$SERVER port=5004
