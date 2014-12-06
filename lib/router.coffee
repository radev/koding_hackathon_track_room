Router.configure
  layoutTemplate: "layout"
  loadingTemplate: "loading"

Router.map ->
  @route "roomNew",
    path: "/"

Router.onBeforeAction "loading"
