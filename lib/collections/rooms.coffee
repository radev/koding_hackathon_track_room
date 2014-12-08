@Rooms = new Mongo.Collection('rooms')

Meteor.methods roomInsert: (messageAttributes) ->
  messageAttributes.default_lang = 'ru'
  check messageAttributes,
    name: String
    default_lang: String

  room = _.extend(messageAttributes,
    created_at: new Date()
  )
  roomId = Rooms.insert(room)
  _id: roomId,
  default_lang: room.default_lang
