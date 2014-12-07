Template.messagesList.helpers messages: ->
  Messages.find({lang: Session.get('lang')}, {sort: {submitted: -1, limit: window.limit} })

window.subscription = null

Template.messagesList.rendered = ->
  $('input[name="name"]').val(Session.get('name'))

  $('input[name="name"]').change ->
    Session.set('name', $(this).val())

  window.subscription = Meteor.subscribe("roomMessages", window.room, Session.get('lang'), window.limit)
  $('select[name="language"]').val(Session.get('lang'))
  $('select[name="language"]').change ->
    window.limit = 30
    window.subscription && subscription.stop();
    Session.set('lang', $(this).val())
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
