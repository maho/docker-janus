var playing = false;
var janus;
var streamHandle;

(function init() {
  Janus.init({
    debug: "all",
    dependencies: Janus.useDefaultDependencies(),
    callback: function() {
      console.log('janus initialized');
      establish();
    }
  });
})();

function establish() {
  var hname = window.location.hostname;
  janus = new Janus({
    server: [
      'ws://' + hname + ':8189/',
      'http://' + hname + ':8188/janus'
    ],
    success: function() {
      console.log('janus connection established:', janus.getServer());
      attach();
    },
    error: function(cause) {
      console.error(cause);
    },
    destroyed: function() {
    }
  });
}

function attach() {
  const opaqueId = "streamingtest-"+Janus.randomString(12);
  janus.attach({
    plugin: 'janus.plugin.streaming',
    opaqueId: opaqueId,
    success: function(pluginHandle) {
      console.log('attached to streaming plugin with handle:', pluginHandle);
      streamHandle = pluginHandle;

      getStreams();
    },
    error: function(cause) {
      console.error(cause);
    },
    onmessage: function(msg, jsep) {
      if (jsep !== undefined && jsep !== null) {
        console.log('handling sdp:', jsep);
        streamHandle.createAnswer({
          jsep: jsep,
          media: { audioSend: false, videoSend: false },
          success: function(ourJsep) {
            var body = { request: 'start' };
            streamHandle.send({ message: body, jsep: ourJsep });
          },
          error: function (cause) {
            console.error(cause);
          }
        });
      }
    },
    onremotestream: function(stream) {
      if (playing) return;
      playing = true;
      console.log('got remote stream:', stream);
      var video = document.getElementById("video-canvas");
      Janus.attachMediaStream(video, stream);
    }
  });
}

function getStreams() {
  console.log('gstStreams()');
  var body = { request: 'list' };
  streamHandle.send({
    message: body,
    success: function(response) {
      console.log('stream list response:', response);
      var firstId = response.list[0].id;
      startStream(firstId);
    },
    error: function (cause) {
      console.error(cause);
    }
  });
}

function startStream(id) {
  console.log('starting stream', id);
  var body = { request: 'watch', id: id };
  streamHandle.send({
    message: body,
    error: function (cause) {
      console.error(cause);
    }
  });
}

