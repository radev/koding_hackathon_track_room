Template.layout.helpers twitterStatus: ->
  return encodeURI('?url='+location.href+'&text=Join me in video-chat now'+'&hashtags=trackroom')

Template.layout.helpers facebookShare: ->
  return encodeURI(location.href)

Template.landingLayout.rendered = ->
  $("body").css("height", "100%");
  $("html").css("height", "100%");


Template.layout.rendered = ->
  $("body").css("height", "");
  $("html").css("height", "");