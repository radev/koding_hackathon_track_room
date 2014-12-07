Template.messagesList.helpers messages: ->
  Messages.find({lang: Session.get('lang')}, {sort: {submitted: -1, limit: Session.get("limit")} })

window.subscription = null

Template.messagesList.rendered = ->
  $('input[name="name"]').val(Session.get('name'))
  $('input[name="name"]').change ->
    Session.set('name', $(this).val())
  window.subscription = Meteor.subscribe("roomMessages", Session.get('room'), Session.get('lang'), Session.get("limit"))
  $('select[name="language"]').val(Session.get('lang'))
  $('select[name="language"]').change ->
    Session.set("limit", 30)
    window.subscription && subscription.stop();
    Session.set('lang', $(this).val())
    window.subscription = Meteor.subscribe("roomMessages", Session.get('room'), Session.get('lang'), Session.get("limit"))
    $(window).unbind('scroll')
    $(window).scroll ->
      incrementLimit()  if $(window).scrollTop() + $(window).height() > $(document).height() - 100
      return
  $(window).scroll ->
    incrementLimit()  if $(window).scrollTop() + $(window).height() > $(document).height() - 100
    return

  return

incrementLimit = ->
  newLimit = Session.get("limit") + 30
  Session.set "limit", newLimit
  return

Template.messagesList.created = ->
  Session.setDefault "limit", 30

  Tracker.autorun ->
    window.subscription = Meteor.subscribe("roomMessages", Session.get('room'), Session.get('lang'), Session.get("limit"))
    return
  return

Template.messagesList.events "click .give-me-more": (evt) ->
  incrementLimit()
  return

