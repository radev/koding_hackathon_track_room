Meteor.methods saveMessage: (messageAttributes) ->

  check messageAttributes,
    name: String
    text: String
    room: String
    lang: String
    submitted: Date

  message = Messages.insert(messageAttributes)

  get_translate = (access_token, from, to, text) ->
    console.log 'get_translate'
    Meteor.http.get  "http://api.microsofttranslator.com/v2/Http.svc/Translate",
      headers:
        Authorization: 'Bearer ' + access_token
      params:
        to: to
        from: from
        text: text
    , (error, result) ->
      if result
        xml2js.parseString result.content, (err, result) ->
          if result
            messageAttributes.text = result.string._
            messageAttributes.lang = to
            Messages.insert(messageAttributes)
      else
        console.log "BUG result get translate"

  get_access_token = ->
    console.log 'get_access_token'
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
          get_translate(result.data.access_token, 'ru', 'en', messageAttributes.text)
        else
          console.log "BUG result get token"


  room = Rooms.findOne messageAttributes.room
  if room.translate_access_token != undefined
    console.log 'exists'
    if room.translate_access_token.expired > Math.round(new Date().getTime()/1000.0)
      console.log 'active'
      get_translate(room.translate_access_token.access_token, 'ru', 'en', messageAttributes.text)
    else
      console.log 'expired'
      get_access_token()
  else
    console.log 'none exists'
    expired = Math.round(new Date().getTime()/1000.0) + 550
    get_access_token()


  return message
