#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

require.paths.unshift("#{__dirname}/..");
routes = app = events = null
should = require 'should'
$ = require 'mock.js'

it = (statement, callback) ->
  module.exports[statement] = ->
    beforeEach()
    callback()

beforeEach = ->
  app = $.mock require('express').createServer()
  events = $.mock require 'lib/events'
  routes = require('lib/routes').inject app, events



it 'should route index page', ->

  expected = 'index route'
  $.when(app).get('/', $.any 'function').thenReturn expected
  routes.index().should.equal expected



it 'should route event update url', ->

  expected = 'event route'
  $.when(app).post('/event', $.any 'function').thenReturn expected
  routes.event().should.equal expected