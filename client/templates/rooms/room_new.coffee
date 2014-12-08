Template.roomNew.rendered = ->
  window.room = undefined
  $('input[name="name"]').val Session.get('name')
  $('select[name="language"]').val Session.get('lang')
