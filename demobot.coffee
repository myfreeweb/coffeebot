{Bot, Local, IRC} = require './src/index'

b = new Bot 'Demobot/1.0'

b.hear /hi/, 'Greet users', (msg) ->
  msg.reply "Hi, #{msg.author}"

b.hear /bye/, (msg) ->
  msg.reply "Bye!"
  process.kill process.pid, 'SIGKILL'

b.help /help/, "I know these commands:"

b.connect new Local
b.connect new IRC 'localhost', 'demobot', ['#test']
