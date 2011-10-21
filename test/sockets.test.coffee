#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

require.paths.unshift("#{__dirname}/..");
sockets = app = now = watchers = null
should = require 'should'
$ = require 'mock.js'

it = (statement, callback) ->
  module.exports[statement] = ->
    beforeEach()
    callback()

beforeEach = ->
  app = $.mock require('express').createServer()
  now = $.mock require('now')
  watchers = stubWatchers()
  sockets = require('lib/sockets').inject app, now, watchers

stubWatchers = ->
  stub = []
  stub.pull = (watcher) ->
    stub.splice (stub.indexOf watcher), 1
    stub.length
  stub

stubEveryone = (connections) ->
  connected: (callback) -> callback()
  disconnected: (callback) -> callback()
  now: count: (n) -> connections.active = n



it 'should setup sockets', ->

  expected = 'everyone'
  $.when(now).initialize(app, $.any 'object').thenReturn expected
  sockets.setup().should.equal expected



it 'should handle new connections', ->

  connections = active: 0
  everyone = stubEveryone(connections)
  $.when(now).initialize(app, $.any 'object').thenReturn everyone

  sockets.setup()
  sockets.connected()

  connections.active.should.be.equal 1



it 'should handle disconnections', ->

  connections = active: 1
  everyone = stubEveryone(connections)
  $.when(now).initialize(app, $.any 'object').thenReturn everyone

  sockets.setup()
  sockets.disconnected()

  connections.active.should.be.equal 0