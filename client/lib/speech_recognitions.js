var recognizing  = false;
if (window.webkitSpeechRecognition) {
var recognition = new webkitSpeechRecognition();
  recognition.continuous = true;
recognition.interimResults = true;

recognition.onstart = function() {
  recognizing = true;
  console.log("Recognition started");
};
recognition.onresult = function(event) {
  var interim_transcript = '';
  var final_transcript = '';
  for (var i = event.resultIndex; i < event.results.length; ++i) {
    if (event.results[i].isFinal) {
      final_transcript += event.results[i][0].transcript;
      console.log("Final: "+ final_transcript);
    } else {
      interim_transcript += event.results[i][0].transcript;
      console.log("Interim: "+ interim_transcript);
    }
  }
};

recognition.onerror = function(e) {
  console.log("Error");
};

recognition.onend = function() {
  console.log("Speech recognition ended");
  recognizing = false;
};

function start_speech() {
  recognition.lang = 'ru-RU'; // 'en-US' works too, as do many others
  recognition.start();
}


var sbutton = $('#voiceRecognitionButton'),
    setsButton = function (bool) {
        sbutton.text(bool ? 'Speech recognition' : 'Stop recognition');
    };
setsButton(true);
sbutton.click(function () {
  if (recognizing) {
    recognition.stop();
    setsButton(true);
    return;
  }
  start_speech();
  setsButton(false);
});

}
