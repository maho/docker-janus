#!/bin/sh

WIDTH=640
HEIGHT=400
BITRATE=768000

gst-launch-1.0 -v videotestsrc is-live=true ! capsfilter caps=video/x-raw,width=$WIDTH,height=$HEIGHT,framerate=30/1 ! timeoverlay ! vp8enc deadline=33333 target-bitrate=$BITRATE ! rtpvp8pay ! udpsink sync=false host=127.0.0.1 port=6000
