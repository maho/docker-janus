#!/bin/sh

WIDTH=320
HEIGHT=240
BITRATE=1024000
SERVER=${JANUS_SERVER:-localhost}
VIDEO_DEVICE=${VIDEO_DEVICE:-/dev/video0}


gst-launch-1.0 \
    audiotestsrc ! \
      audioresample ! audio/x-raw,channels=1,rate=16000 ! \
      opusenc bitrate=20000 ! \
        rtpopuspay ! udpsink host=$SERVER port=5002 \
    \
    v4l2src device=/dev/video0 ! \
    video/x-raw,width=$WIDTH,height=$HEIGHT,framerate=15/1 ! \
    videoscale ! videorate ! videoconvert ! timeoverlay ! \
    vp8enc error-resilient=1 ! \
      rtpvp8pay ! udpsink host=$SERVER port=5004

false gst-launch-1.0 -v alsasrc device=plughw:2,0 ! mulawenc ! rtppcmupay ! udpsink host=$SERVER port=6001 &

false gst-launch-1.0 -v v4l2src device=/dev/video0  \
! capsfilter caps=video/x-raw,width=$WIDTH,height=$HEIGHT \
! videoconvert \
! timeoverlay \
! queue \
! vp8enc deadline=33333 cpu-used=16 target-bitrate=$BITRATE keyframe-max-dist=90 max-quantizer=24 \
! rtpvp8pay \
! udpsink host=$SERVER port=5004 sync=false qos=true

false gst-launch-1.0 alsasrc device=plughw:2,0 ! audioconvert ! audioresample  ! alawenc ! rtppcmapay \
    ! udpsink host=$SERVER port=6000 sync=false qos=true

false gst-launch-1.0 -v alsasrc device=plughw:2,0 ! audioconvert ! opusenc \
! rtpvp8pay \
! udpsink host=$SERVER port=6000 sync=false qos=true

