Template.roomNew.events "click #addRoom": ->
  room =
    name: 'some room'

  Meteor.call "roomInsert", room, (error, result) ->

    # отобразить ошибку пользователю и прерваться
    return alert(error.reason)  if error

    Router.go "roomView",
      _id: result._id

    return
