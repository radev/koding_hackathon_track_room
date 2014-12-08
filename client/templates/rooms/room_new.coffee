Template.roomNew.rendered = ->
  window.room = undefined
  $('input[name="name"]').val Session.get('name')
  if Session.get('lang')
    $('select[name="language"]').val Session.get('lang')

