Template.messagesList.helpers messages: ->
  Messages.find({}, {sort: {submitted: -1} })

subscription = null

Template.messagesList.rendered = ->
  room = @.data._id
  room = @.data.room._id unless room
  $('input[name="name"]').val(Session.get('name'))
  subscription = Meteor.subscribe("roomMessages", room, $('select[name="language"]').val())
  $('select[name="language"]').change ->
    subscription && subscription.stop();
    subscription = Meteor.subscribe("roomMessages", room, $('select[name="language"]').val())
  $('input[name="name"]').change ->
    Session.set('name', $(this).val())