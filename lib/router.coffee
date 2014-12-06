Router.configure
  layoutTemplate: "layout"
  loadingTemplate: "loading"

Router.map ->
  @route "roomNew",
    path: "/"

  @route "roomView",
    path: "/rooms/:_id"
    waitOn: ->
      [
        Meteor.subscribe("singleRoom", @params._id)
        Meteor.subscribe("roomMessages", @params._id)
      ]
     data: ->
      room: Rooms.findOne _id: @params._id

Router.onBeforeAction "loading"

# Router.onAfterAction ->
#   debugger
