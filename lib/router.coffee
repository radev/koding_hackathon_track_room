Router.configure
  layoutTemplate: "layout"
  loadingTemplate: "loading"

Router.map ->
  @route "roomNew",
    path: "/"

  @route "roomView",
    path: "/rooms/:_id/:lang"
    waitOn: ->
      [
        Meteor.subscribe("singleRoom", @params._id)
        Meteor.subscribe("roomMessages", @params._id, @params.lang)
      ]
     data: ->
      room: Rooms.findOne _id: @params._id
      lang: @params.lang

Router.onBeforeAction "loading"

# Router.onAfterAction ->
#   debugger
