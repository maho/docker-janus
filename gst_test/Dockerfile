FROM ubuntu:20.04


RUN apt-get update -y  # TODO: merge it with rest of commands
RUN apt-get install -y gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-plugins-rtp
RUN apt-get install -y gstreamer1.0-tools
# TODO: cleanup of files


ADD run.sh /run.sh

CMD /run.sh
