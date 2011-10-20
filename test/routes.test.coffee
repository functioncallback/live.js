#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

require.paths.unshift("#{__dirname}/..");
routes = app = null
should = require 'should'
$ = require 'mock.js'

it = (statement, callback) ->
  beforeEach()
  module.exports[statement] = callback

beforeEach = ->
  app = $.mock require('express').createServer()
  routes = require('lib/routes').inject app

it 'should route index', ->

  expected = 'indexRoute'
  $.when(app).get('/', $.any 'function').thenReturn expected
  routes.index().should.equal expected