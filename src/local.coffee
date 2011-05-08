readline = require 'readline'
{EventEmitter} = require 'events'

class Local extends EventEmitter
  constructor: ->
    # https://github.com/jashkenas/coffee-script/blob/master/src/repl.coffee
    stdin = process.openStdin()
    stdout = process.stdout
    autocomplete = (text) -> [[], text]
    if readline.createInterface.length < 3
      @repl = readline.createInterface stdin, autocomplete
      stdin.on 'data', (buffer) -> repl.write buffer
    else
      repl = readline.createInterface stdin, stdout, autocomplete
    repl.setPrompt 'chat> '
    repl.on 'close', -> stdin.destroy()
    repl.on 'line', (buffer) =>
      @emit 'message', author: 'tester', text: buffer.toString(), account: this
      repl.prompt()
    repl.prompt()
    @on 'post', (text) ->
      console.log text

exports.Local = Local
