Template.roomNew.events "click #addRoom": (event) ->
  event.preventDefault()
  Session.set 'name', $('input[name="name"]').val()
  Session.set 'lang', $('select[name="language"]').val()
  room =
    name: 'some room'
    default_lang: Session.get('lang')
  Meteor.call "roomInsert", room, (error, result) ->

    # отобразить ошибку пользователю и прерваться
    return alert(error.reason)  if error

    Router.go "roomView",
      _id: result._id
      lang: Session.get('lang')

    return
