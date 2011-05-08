{Bot, Local} = require './src/index'

b = new Bot

b.hear /hi/, 'Greet users', (msg) ->
  msg.reply "Hi, #{msg.author}"

b.connect new Local
