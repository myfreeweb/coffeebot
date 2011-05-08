{Bot, Local, IRC} = require './src/index'

b = new Bot

b.hear /hi/, 'Greet users', (msg) ->
  msg.reply "Hi, #{msg.author}"

b.hear /bye/, (msg) ->
  msg.reply "Bye!"
  process.kill process.pid, 'SIGKILL'

b.connect new Local
b.connect new IRC 'localhost', 'demobot', ['#test']
