Template.roomView.events "submit form": (e) ->
  e.preventDefault()
  message =
    name: $('#name').val()
    text: $(e.target).find("[name=message]").val()
    room: Rooms.findOne()._id
    lang: $('select[name="language"]').val()

  unless $(e.target).find("[name=message]").val() == ""
    Meteor.call "messageInsert", message, (error, result) ->

      # отобразить ошибку пользователю и прерваться
      return alert(error.reason)  if error

    $(e.target).find("[name=message]").val('')
    $(e.target).find("[name=message]").focus()
    $("#chat").scrollTop(99999)
    return
