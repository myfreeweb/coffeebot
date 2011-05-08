irc = require 'irc'
{EventEmitter} = require 'events'

class IRC extends EventEmitter
  constructor: (server, username, channels) ->
    @client = new irc.Client server, username, channels: channels
    @channels = channels
    @client.on 'message', (author, to, text) =>
      @emit 'message', author: author, text: text, account: this
    @on 'post', (text) =>
      for channel in @channels
        @client.say channel, text
    @on 'join', (channel) =>
      @channels.push channel
      @client.join channel

exports.IRC = IRC
