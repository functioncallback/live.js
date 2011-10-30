#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require('cappuccino').inject(module.exports)
sockets = app = now = watchers = null
stub = require './stubs/stub'

$.before ->
  app = $.mock require('express').createServer()
  now = $.mock require('now')
  watchers = stub.watchers()
  sockets = require('../lib/sockets').inject app, now, watchers



$.it 'should setup sockets', ->

  expected = 'everyone'
  $.when(now).initialize(app, $.any 'object').thenReturn expected
  sockets.setup().should.equal expected



$.it 'should handle new connections', ->

  connections = active: 0
  everyone = stub.everyone(connections)
  $.when(now).initialize(app, $.any 'object').thenReturn everyone

  sockets.setup()
  sockets.connected()

  connections.active.should.be.equal 1



$.it 'should handle disconnections', ->

  connections = active: 1
  everyone = stub.everyone(connections)
  $.when(now).initialize(app, $.any 'object').thenReturn everyone

  sockets.setup()
  sockets.disconnected()

  connections.active.should.be.equal 0