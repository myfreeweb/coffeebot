fs = require 'fs'
version  = JSON.parse(fs.readFileSync(__dirname + '/../package.json', 'utf-8')).version

class Bot
  constructor: (ua = 'Bot/0.0') ->
    # format: { re: /regexp/, desc: 'string', callback: function }
    @handlers = []
    # format: EventEmitter, emits 'message' and gets 'post'
    @accounts = []
    @set_ua ua

  # format: { author: 'string', text: 'string', account: account }
  dispatch: (msg) ->
    for handler in @handlers
      if match = msg.text.match handler.re
        msg.match = match
        msg.reply = (text) ->
          msg.account.emit 'post', text
        handler.callback msg

  say_all: (text) ->
    for account in @accounts
      account.emit 'post', text

  hear: (re, desc, callback) ->
    if typeof desc == 'function'
      callback = desc
      desc = ''
    @handlers.push re: re, desc: desc, callback: callback

  connect: (account) ->
    account.on 'message', (msg) =>
      @dispatch msg
    try
      account.emit 'set_ua', @ua
    catch err
    @accounts.push account

  set_ua: (ua) ->
    @ua = "#{ua} coffeebot/#{version} node/#{process.versions.node}"
    for account in @accounts
      try
        account.emit 'set_ua', @ua
      catch err

  help: (re, desc) =>
    @hear re, (msg) =>
      help = @handlers.map (h) ->
        if h.re isnt re
          s = h.re.toString().replace(/\//g, '')
          s += ": " + h.desc if h.desc
          s
      msg.reply "#{desc}\n#{help.join "\n"}"

exports.Bot = Bot
