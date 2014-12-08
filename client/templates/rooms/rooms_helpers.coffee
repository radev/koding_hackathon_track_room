Template.roomView.created = ->
  room = @.data._id
  room = @.data.room._id unless room
  default_lang = @.data.default_lang
  default_lang = @.data.room.default_lang unless default_lang
  window.room = room
  Session.setDefault "lang", default_lang
  return

Template.roomView.rendered = ->
  $('#saveFile').attr('href', '/rooms/' + window.room + '/' + Session.get('lang') + '/save')