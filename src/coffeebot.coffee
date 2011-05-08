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
      if handler.re.test msg.text
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
    @ua = "#{ua} coffeebot/0.0 node/#{process.versions.node}"
    for account in @accounts
      try
        account.emit 'set_ua', @ua
      catch err

exports.Bot = Bot
