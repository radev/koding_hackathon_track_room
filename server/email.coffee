process.env.MAIL_URL="smtp://mailtrackroom%40gmail.com:aDoLaXXz@smtp.gmail.com:465/";
config_domain = 'http://localhost:3000/'

#Meteor.call "sendEmailInvite", 'nikzp@inbox.ru', 'aAnPvxwNFBmgDuc6r'

Meteor.methods sendEmailInvite: (emails, room) ->
  check emails, String
  check room, String
  emails = emails.split(',')
  i = 0
  while i < emails.length
    dataContext =
      message: "To join go to",
      url: config_domain + "rooms/" + room,
      title: "Join to TrackRoom:"
    html = Handlebars.templates['invite_email'](dataContext);
    Email.send({
      from: "emailtrackroom@gmail.com",
      to: emails[i],
      subject: "You are invited to dialogue in TrackRoom",
      html: html
    });
    i++
  return
