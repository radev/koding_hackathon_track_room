Template.messagesList.helpers messages: ->
  Messages.find({lang: Session.get('lang')}, {sort: {submitted: -1, limit: window.limit} })

window.subscription = null

Template.messageItem.helpers myMessage: ->
  if Session.get('name') == @.name
    return 'my col-lg-7 col-lg-offset-5'
  else
    return 'remote col-lg-7'


Template.messagesList.rendered = ->
  $('input[name="name"]').val(Session.get('name'))

  $('input[name="name"]').change ->
    if Session.get('name')
      Meteor.call "updateNameUser", Session.get('name'), $(this).val() || '', window.room, (error, result) ->
        alert(error.reason)  if error
        if result.result
          Session.set('name', $('input[name="name"]').val())
        else
          alert(result.message)
          $('input[name="name"]').val(Session.get('name'))

        return


  window.subscription = Meteor.subscribe("roomMessages", window.room, Session.get('lang'), window.limit)
  $('select[name="language"]').val(Session.get('lang'))
  $('select[name="language"]').change ->

    window.limit = 30
    window.subscription && subscription.stop();
    Session.set('lang', $(this).val())
    $('#saveFile').attr('href', '/rooms/' + window.room + '/' + Session.get('lang') + '/save')
    window.subscription = Meteor.subscribe("roomMessages", window.room, Session.get('lang'), window.limit)
    $(window).unbind('scroll')
    $(window).scroll ->
      incrementLimit()  if $(window).scrollTop() + $(window).height() > $(document).height() - 100
      return
  $(window).scroll ->
    incrementLimit()  if $(window).scrollTop() + $(window).height() > $(document).height() - 100
    return

  return

incrementLimit = ->
  newLimit = window.limit + 30
  window.limit = newLimit
  return

Template.messagesList.created = ->
  window.limit = 30

  Tracker.autorun ->
    window.subscription = Meteor.subscribe("roomMessages", window.room, Session.get('lang'), window.limit)
    return
  return

Template.messagesList.events "click .give-me-more": (evt) ->
  incrementLimit()
  return
