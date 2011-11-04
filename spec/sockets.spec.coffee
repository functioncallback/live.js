#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

describe 'sockets', ->

  stub = require './support/stub'
  root = stub.root

  sockets = app = now = watchers = null



  beforeEach ->

    app = mock require('express').createServer()
    now = mock require('now')
    watchers = stub.watchers()
    sockets = require(root '/lib/sockets').inject app, now, watchers



  it 'should setup sockets', ->

    expected = 'everyone'
    upon(now).initialize(app, match.any 'object').thenReturn expected
    expect(sockets.setup()).toBe expected



  it 'should handle new connections', ->

    connections = active: 0
    everyone = stub.everyone(connections)
    upon(now).initialize(app, match.any 'object').thenReturn everyone

    sockets.setup()
    sockets.connected()

    expect(connections.active).toBe 1



  it 'should handle disconnections', ->

    connections = active: 1
    everyone = stub.everyone(connections)
    upon(now).initialize(app, match.any 'object').thenReturn everyone

    sockets.setup()
    sockets.disconnected()

    expect(connections.active).toBe 0