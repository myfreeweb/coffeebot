class Bot
  constructor: ->
    # format: { re: /regexp/, desc: 'string', callback: function }
    @handlers = []
    # format: EventEmitter, emits 'message' and gets 'post'
    @accounts = []
    # format: function
    @onerror  = console.log

  # format: { author: 'string', text: 'string', account: account }
  dispatch: (msg) ->
    for handler in @handlers
      do =>
        if handler.re.test msg.text
          msg.reply = (text) ->
            msg.account.post text
          handler.callback msg

  say_all: (text) ->
    for account in @accounts
      do =>
        account.emit 'post', text

  hear: (re, desc, callback) ->
    @handlers.push re: re, desc: desc, callback: callback

  connect: (account) ->
    account.on 'message', (msg) ->
      @dispatch msg
    @accounts.push account

  error: (callback) ->
    @onerror = callback
