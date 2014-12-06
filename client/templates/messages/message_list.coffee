Template.messagesList.helpers messages: ->
  Messages.find()

Template.messagesList.rendered = ->
  room =
  Meteor.subscribe("roomMessages", this.data.room._id, $('select[name="language"]').val() )
  $('select[name="language"]').change ->
    Meteor.subscribe("roomMessages", @params._id, $('select[name="language"]').val() )