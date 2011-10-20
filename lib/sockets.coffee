#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

module.exports = inject: (app, nowjs) ->

  init: ->
    @initializeNowjs()

  initializeNowjs: ->
    everyone = nowjs.initialize app, socketio: 'log level': 2