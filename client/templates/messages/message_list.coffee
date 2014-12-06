Template.messagesList.helpers messages: ->
  Messages.find()

Template.messagesList.rendered = ->
  $('select[name="language"]').val(this.data.lang)
  $('select[name="language"]').change ->
    window.location.href = window.location.href.substr(0, window.location.href.length - 2) + $(this).val()