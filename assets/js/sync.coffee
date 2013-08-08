class Sync

  shouldListen: true
  prev: [ 33, 37, 38 ] #pgup, left, up
  next: [ 9, 32, 34, 39, 40 ] #tab, space, pgdown, right, down
  path: "/advance"
  server: "http://localhost:9292/faye"

  constructor: ->
    document.onkeyup = @checkKey
    @client = new Faye.Client @server
    @subscription = @client.subscribe @path, @recieveMessage

  checkKey: (e) =>

    if e.keyCode in @next
      @sendMessage "next"

    else if e.keyCode in @prev
      @sendMessage "previous"

  sendMessage: (message) ->
    @shouldListen = false
    @client.publish @path,
      action: message

  recieveMessage: (message) =>
    return unless @shouldListen
  
    if message.action is "next"
      impress().next()
    else if message.action is "previous"
      impress().prev() 
  
    @shouldIListen = true

window.sync = new Sync() if Faye?