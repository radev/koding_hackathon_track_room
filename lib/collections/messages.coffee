@Messages = new Mongo.Collection("messages")

Meteor.methods messageInsert: (messageAttributes) ->
  check messageAttributes,
    name: String
    text: String
    room: String

  message = _.extend(messageAttributes,
    submitted: new Date()
  )
  Messages.insert(message)
  return
