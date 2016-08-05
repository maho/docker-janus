# docker-janus

Run up a [janus-gateway](https://github.com/meetecho/janus-gateway) instance using docker.

## Streaming test

1. Install docker and GStreamer 1.0.

2. Build this image with `make image`

3. Run the Janus server with `make run`.  This will forward some ports: 8088/tcp (HTTP), 8188/tcp (WebSocket), 6000/udp (RTP)

4. Run `./gst_launch.sh` to start sending RTP to Janus.

5. Start an HTTP server in `webapps/` and browse to the index.  You should see a test pattern.
