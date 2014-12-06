@Messages = new Mongo.Collection("messages")

Meteor.methods messageInsert: (messageAttributes) ->
  check messageAttributes,
    name: String
    text: String
    room: String
    lang: String

  message = _.extend(messageAttributes,
    submitted: new Date()
  )
  Meteor.call('saveMessage', message);
  # Messages.insert(message)

  return
