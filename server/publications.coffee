Meteor.publish "messages", ->
  Messages.find()

Meteor.publish "roomMessages", (roomId) ->
  check roomId, String
  Messages.find room: roomId

Meteor.publish "singleRoom", (roomId) ->
  check roomId, String
  Rooms.find roomId
