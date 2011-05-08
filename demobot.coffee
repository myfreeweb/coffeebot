{Bot} = require './src/coffeebot'
{Local} = require './src/local'

b = new Bot

b.hear /hi/, 'Greet users', (msg) ->
  msg.reply "Hi, #{msg.author}"

b.connect new Local
