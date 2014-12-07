
Template.videoList.rendered = ->

  showVolume = (el, volume) ->
    return  unless el
    if volume < -45 # vary between -45 and -20
      el.style.height = "0px"
    else if volume > -20
      el.style.height = "100%"
    else
      el.style.height = "" + Math.floor((volume + 100) * 100 / 25 - 220) + "%"

  setRoom = (name) ->
    $("#linktoroom").text " - " + location.href
    $("#linktoroom").attr "href", location.href
    $("body").addClass "active"

  room = @.data.room._id
  room = @.data._id unless room
  webrtc = new SimpleWebRTC(
    localVideoEl: "localVideo"
    remoteVideosEl: ""
    autoRequestMedia: true
    debug: false
    detectSpeakingEvents: true
    autoAdjustMic: false
  )
  webrtc.on "readyToCall", ->
    webrtc.joinRoom room  if room
    return

  webrtc.on "channelMessage", (peer, label, data) ->
    showVolume document.getElementById("volume_" + peer.id), data.volume  if data.type is "volume"
    return

  webrtc.on "videoAdded", (video, peer) ->
    console.log "video added", peer
    remotes = $('.remotes')
    if remotes
      d = document.createElement("div")
      d.className = "videoContainer col-lg-3"
      d.id = "container_" + webrtc.getDomId(peer)
      d.appendChild video
      vol = document.createElement("div")
      vol.id = "volume_" + peer.id
      vol.className = "volume_bar"
      d.appendChild vol
      remotes.append d
    return

  webrtc.on "videoRemoved", (video, peer) ->
    console.log "video removed ", peer
    remotes = $('.remotes')
    el = document.getElementById("container_" + webrtc.getDomId(peer))
    remotes.find($(el)).remove()  if remotes and el
    return

  webrtc.on "volumeChange", (volume, treshold) ->
    showVolume document.getElementById("localVolume"), volume
    return

  recognizing = false
  if window.webkitSpeechRecognition
    start_speech = ->
      # recognition.lang = "ru-RU" # 'en-US' works too, as do many others
      recognition.lang = $('select[name="language"]').val() # 'en-US' works too, as do many others
      recognition.start()
      return
    recognition = new webkitSpeechRecognition()
    recognition.continuous = true
    recognition.interimResults = true
    recognition.onstart = ->
      recognizing = true
      console.log "Recognition started"
      return

    recognition.onresult = (event) ->
      interim_transcript = ""
      final_transcript = ""
      i = event.resultIndex

      while i < event.results.length
        if event.results[i].isFinal
          final_transcript += event.results[i][0].transcript
          Meteor.call 'messageInsert', { name: $('input[name="name"]').val(), text: final_transcript, room: Session.get('room'), lang: @.lang }
        else
          interim_transcript += event.results[i][0].transcript
        ++i
      return

    recognition.onerror = (e) ->
      console.log "Error"
      return

    recognition.onend = ->
      console.log "Speech recognition ended"
      recognizing = false
      return

    vbutton = $(".toggleVideo")
    sbutton = $(".toggleMic")
    setsButton = (bool) ->
      if bool
        color = "#aeb2b7"
      else
        color = "#FFD777"
      sbutton.css 'color', color
      return

    setsButton true
    vbutton.on 'click', (event) ->
      event.preventDefault()
      # webrtc.startLocalVideo()
      # debugger

    sbutton.on 'click', (event) ->
      event.preventDefault()
      if recognizing
        recognition.stop()
        setsButton true
        return
      start_speech()
      setsButton false
      return



  setRoom room
