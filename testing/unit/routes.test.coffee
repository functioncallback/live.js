#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require('cappuccino').inject(module.exports)
stub = require './support/stub'
root = stub.root

routes = app = events = null



$.before ->

  app = $.mock require('express').createServer()
  events = $.mock require root '/lib/events'
  routes = require(root '/lib/routes').inject app, events



$.it 'should route index page', ->

  expected = 'index route'
  $.when(app).get('/', $.any 'function').thenReturn expected
  routes.index().should.equal expected



$.it 'should route event update url', ->

  expected = 'event route'
  $.when(app).post('/event', $.any 'function').thenReturn expected
  routes.event().should.equal expected