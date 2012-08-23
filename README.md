[![build status](https://secure.travis-ci.org/myfreeweb/coffeebot.png)](http://travis-ci.org/myfreeweb/coffeebot)
# Coffeebot #
a CoffeeScript framework for writing cross-network chat bots.
Inspired by [evilbot](https://github.com/defunkt/evilbot).

## Installation ##
`npm install coffeebot`

## Supported networks ##
- local readline for debugging
- IRC

## Coming soon ##
- Convore
- XMPP/Jabber conferences
- DSL-ish thing

## Show me the code! ##
    {Bot, IRC} = require 'coffeebot'
    b = new Bot 'MyAwesomeBot/1.2.0'
    b.hear /go to hell/, (msg) ->
      msg.reply "No you go to hell #{msg.author}!!! >_<"
    b.help /help/, "I know this stuff:"
    b.connect new IRC 'localhost', 'awesomebot', ['#test']
