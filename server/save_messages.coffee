Meteor.methods saveMessage: (messageAttributes) ->
  check messageAttributes,
    name: String
    text: String
    room: String
    lang: String
    submitted: Date

  message = Messages.insert(messageAttributes)

  get_translate = (access_token, from, to, text) ->
    if from != '' && to != ''
      Meteor.http.get  "http://api.microsofttranslator.com/v2/Http.svc/Translate",
        headers:
          Authorization: 'Bearer ' + access_token
        params:
          from: from
          to: to
          text: text
      , (error, result) ->
        if result
          if result.statusCode == 200
            xml2js.parseString result.content, (err, result) ->
              if result
                messageAttributes.text = result.string._
                messageAttributes.lang = to
                Messages.insert(messageAttributes)
          else
            messageAttributes.text = 'Error in translation'
            Messages.insert(messageAttributes)
        else
          console.log "BUG result get translate"

  get_access_token = ->
    Meteor.http.post  "https://datamarket.accesscontrol.windows.net/v2/OAuth2-13",
      headers:
        'Content-Type': 'application/x-www-form-urlencoded'
      params:
        grant_type: "client_credentials"
        scope: "http://api.microsofttranslator.com"
        client_id: 'itbeaver-translator'
        client_secret: 'CjUr+7L2+SqeTxNgKgnl+OBn7hczCXFWJG9Nq6R/gDs='
      , (error, result) ->
        if result
          Rooms.update
            _id: room._id
          ,
            $set:
              translate_access_token:
                access_token: result.data.access_token
                expired: expired
          get_translate(result.data.access_token, from, to, messageAttributes.text)
        else
          console.log "BUG result get token"

  expired = 0
  from = ''
  to = ''
  room = Rooms.findOne messageAttributes.room
  if room.languages.length > 1
    i = 0
    while i < room.languages.length
      if room.languages[i] != messageAttributes.lang
        from = messageAttributes.lang
        to = room.languages[i]
        if room.translate_access_token != undefined
          if room.translate_access_token.expired > Math.round(new Date().getTime()/1000.0)
            get_translate(room.translate_access_token.access_token, from, to, messageAttributes.text)
          else
            expired = Math.round(new Date().getTime()/1000.0) + 550
            get_access_token()
        else
          expired = Math.round(new Date().getTime()/1000.0) + 550
          get_access_token()
      i++
  return message
