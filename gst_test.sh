#!/bin/sh

gst-launch-1.0 -v videotestsrc ! vp8enc deadline=33333 ! rtpvp8pay ! udpsink sync=false host=127.0.0.1 port=6000
