# Treat a dog with camera preview 

Run up a [janus-gateway](https://github.com/meetecho/janus-gateway) instance using docker, 

## Demonstration of streaming camera audio + video to web browser

1. install docker-compose
2. run `VIDEO_DEVICE=/dev/video0 ALSA_DEVICE=plughw:2,0 JANUS_SERVER=<your_ip> docker-compose up` 
    assuming that your camera has `/dev/video0` device and your recording audio source is
    at plughw:2,0

    important: you need to set JANUS_SERVER to ip of your computer, otherwisre gstreamer
    source won't be able to stream data from camera to janus. I have no idea why I cannot
    provide localhost or host.docker.internal

3. open browser at http://localhost:8000

you should see a view of camera and hear sounds from your microphone. Also you should see
buttons to send "treat" commands to `upython-vs-dog` ESP32

