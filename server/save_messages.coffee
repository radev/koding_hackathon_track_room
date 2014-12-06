Meteor.methods saveMessage: (messageAttributes) ->

  check messageAttributes,
    name: String
    text: String
    room: String
    lang: String
    submitted: Date

  message = Messages.insert(messageAttributes)

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
      Meteor.http.get  "http://api.microsofttranslator.com/v2/Http.svc/Translate",
        headers:
          Authorization: 'Bearer ' + result.data.access_token
        params:
          to: "en"
          from: "ru"
          text: messageAttributes.text
      , (error, result) ->
        if result
          xml2js.parseString result.content, (err, result) ->
            if result
              messageAttributes.text = result.string._
              messageAttributes.lang = 'en'
              Messages.insert(messageAttributes)
        else
          console.log "BUG result get translate"
    else
      console.log "BUG result get token"


  return message
