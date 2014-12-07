Template.layout.events "click #saveFile": ->
  Meteor.call "saveFile", room, (error, result) ->

    return alert(error.reason)  if error
