@Messages = new Mongo.Collection("messages")

Meteor.methods messageInsert: (messageAttributes) ->

  check messageAttributes,
    name: String
    text: String
    room: String
    lang: String

  messageAttributes = _.extend(messageAttributes,
    submitted: new Date()
  )
  message = Messages.insert(messageAttributes)
  Meteor.call "messageTranslate", messageAttributes, (error, result) ->
    return error.reason if error
  return message

