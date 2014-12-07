Template.layout.helpers twitterStatus: ->
  return encodeURI('?url='+location.href+'&text=Join me in video-chat now'+'&hashtags=trackroom')

Template.layout.helpers facebookShare: ->
  return encodeURI(location.href)