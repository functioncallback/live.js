#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

describe 'routes', ->

  stub = require './support/stub'
  root = stub.root

  routes = app = events = null



  beforeEach ->

    app = mock require('express').createServer()
    events = mock require root '/lib/events'
    routes = require(root '/lib/routes').inject app, events



  it 'should route index page', ->

    expected = 'index route'
    upon(app).get('/', match.any 'function').thenReturn expected
    expect(routes.index()).toBe expected



  it 'should route event update url', ->

    expected = 'event route'
    upon(app).post('/event', match.any 'function').thenReturn expected
    expect(routes.event()).toBe expected