Template.messagesList.helpers messages: ->
  Messages.find({}, {sort: {submitted: -1} })

subscription = null

Template.messagesList.rendered = ->
  room = @.data._id
  room = @.data.room._id unless room
  subscription = Meteor.subscribe("roomMessages", room, $('select[name="language"]').val())
  $('select[name="language"]').change ->
    $('#chat').empty()
    subscription && subscription.stop();
    subscription = Meteor.subscribe("roomMessages", room, $('select[name="language"]').val())