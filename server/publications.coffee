Meteor.publish "messages", ->
  Messages.find()

Meteor.publish "roomMessages", (roomId, lang) ->
  check roomId, String
  check lang, String
  room = Rooms.findOne roomId
  if room.languages != undefined
    languages = room.languages
  else
    languages = []
  if languages.indexOf(lang) == -1
    languages.push(lang)
  Rooms.update
    _id: roomId
  ,
    $set:
      languages: languages

  Messages.find room: roomId, lang: lang

Meteor.publish "singleRoom", (roomId) ->
  check roomId, String
  Rooms.find roomId,
    fields:
      translate_access_token: false

