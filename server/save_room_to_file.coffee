Meteor.methods saveFile: (room) ->

  check room, String


  fs = Npm.require("fs")
  base_path = process.env.PWD
  console.log(base_path)
  fs.writeFile base_path + "/message.txt", "Hello Node", (err) ->
    throw err  if err
    console.log "It's saved!"
    return

  # path = cleanPath(path)
  # fs = __meteor_bootstrap__.require("fs")
  # name = cleanName(name or "file")
  # encoding = encoding or "binary"
  # chroot = Meteor.chroot or "public"
  # path = chroot + ((if path then "/" + path + "/" else "/"))
  # fs.writeFile path + name, blob, encoding, (err) ->
  #   if err
  #     throw (new Meteor.Error(500, "Failed to save file.", err))
  #   else
  #     console.log "The file " + name + " (" + encoding + ") was saved to " + path
  #   return
  #
  # return
