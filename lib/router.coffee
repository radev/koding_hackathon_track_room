Router.configure
  layoutTemplate: "layout"
  loadingTemplate: "loading"


Router.map ->
  @route "roomNew",
    path: "/"

  @route 'jsonExample',
    path: '/rooms/:_id/:lang/save',
    where: 'server',
    action: ->
      filename = 'TrackRoom.txt'
      headers = {
        'Content-Type': 'text/plain',
        'Content-Disposition': "attachment; filename=" + filename
      };
      messages = Messages.find
        room: @params._id
        lang: @params.lang
      ,
        $sort:
          submitted: 1

      text = ''
      messages.forEach (message) ->
        console.log message.submitted
        text = text + message.submitted + ' ' + message.name + ': ' + message.text + '\n'

      this.response.writeHead(200, headers);
      return this.response.end(text);


  @route "roomView",
    path: "/rooms/:_id"
    waitOn: ->
      [
        Meteor.subscribe("singleRoom", @params._id)
      ]
     data: ->
      room: Rooms.findOne _id: @params._id




Router.onBeforeAction "loading", {except: ['jsonExample']}

# Router.onAfterAction ->
#   debugger
