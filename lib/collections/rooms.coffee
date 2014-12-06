@Rooms = new Mongo.Collection('rooms')

Meteor.methods roomInsert: (messageAttributes) ->
  check messageAttributes,
    name: String

  room = _.extend(messageAttributes,
    created_at: new Date()
  )
  roomId = Rooms.insert(room)
  _id: roomId
