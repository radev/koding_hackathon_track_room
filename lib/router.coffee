Router.configure
  layoutTemplate: "landingLayout"
  loadingTemplate: "loading"

Router.map ->
  @route "roomNew",
    path: "/"

  @route "roomView",
    path: "/rooms/:_id"
    layoutTemplate: 'layout'
    waitOn: ->
      [
        Meteor.subscribe("singleRoom", @params._id)
      ]
     data: ->
      room: Rooms.findOne _id: @params._id

Router.onBeforeAction "loading"

# Router.onAfterAction ->
#   debugger
