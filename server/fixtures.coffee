if Rooms.find().count() is 0
  Rooms.insert
    name: "Room 1"
    submitted: new Date()

  Rooms.insert
    name: "Room 2"
    submitted: new Date()

if Messages.find().count() is 0
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
