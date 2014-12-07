if Rooms.find().count() is 0
  Rooms.insert
    name: "Room 1"
    default_lang: 'ru'
    submitted: new Date()

  Rooms.insert
    name: "Room 2"
    submitted: new Date()

if Messages.find().count() is 0
  i = 1
  while i < 1000
    Messages.insert
      name: "Meteor"
      lang: 'ru'
      text: "Кое какой текст " + String(i)
      room: Rooms.findOne()._id
      submitted: new Date()

    Messages.insert
      name: "Meteor"
      lang: 'en'
      text: "Some text " + String(i)
      room: Rooms.findOne()._id
      submitted: new Date()
    i++

  Messages.insert
    name: "Meteor"
    text: "Some text 1"
    room: Rooms.findOne()._id
    submitted: new Date()

  Messages.insert
    name: "Al"
    text: "Text message"
    room: Rooms.findOne()._id
    submitted: new Date()

