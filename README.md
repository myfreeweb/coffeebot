# Coffeebot #
a CoffeeScript framework for writing cross-network chat bots.

## Supported networks ##
- local readline for debugging
- IRC

## Coming soon ##
- Convore
- XMPP/Jabber conferences
- DSL-ish thing
- package.json

## Show me the code! ##
    {Bot, IRC} = require 'coffeebot'
    b = new Bot 'MyAwesomeBot/1.2.0'
    b.hear /go to hell/, (msg) ->
      msg.reply "No you go to hell #{msg.author}!!! >_<"
    b.help /help/, "I know this stuff:"
    b.connect new IRC 'localhost', 'awesomebot', ['#test']
