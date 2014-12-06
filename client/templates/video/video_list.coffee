

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

  room = @.data._id
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

  setRoom room
