#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

module.exports = inject: (app, now, watchers) ->

  everyone = undefined

  init: ->
    @setup()
    @connected()
    @disconnected()

  setup: ->
    everyone = now.initialize app, socketio: 'log level': 2

  connected: ->
    everyone.connected ->
      everyone.now.count watchers.push this.now

  disconnected: ->
    everyone.disconnected ->
      everyone.now.count watchers.pull this.now