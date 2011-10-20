#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

require.paths.unshift("#{__dirname}/..");
sockets = app = nowjs = null
should = require 'should'
$ = require 'mock.js'

it = (statement, callback) ->
  beforeEach()
  module.exports[statement] = callback

beforeEach = ->
  app = $.mock require('express').createServer()
  nowjs = $.mock require('now')
  sockets = require('lib/sockets').inject app, nowjs

it 'should initialize nowjs', ->

  expected = 'everyone'
  $.when(nowjs).initialize(app, $.any 'object').thenReturn expected
  sockets.initializeNowjs().should.equal expected