#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

root = (path) -> "#{__dirname.substr(0, __dirname.length-5)}/lib/..#{path}"
require.paths.unshift("#{__dirname}/..");
app = express = expressApp = stylus = nib = nowjs = routes = sockets = null
should = require 'should'
$ = require 'mock.js'

it = (statement, callback) ->
  beforeEach()
  module.exports[statement] = callback

beforeEach = ->
  express = $.mock require 'express'
  stylus  = $.mock require 'stylus'
  nib     = $.mock require 'nib'
  nowjs   = $.mock require 'now'
  routes  = $.mock require 'lib/routes'
  sockets = $.mock require 'lib/sockets'
  app = require('lib/app').inject express, stylus, nib, nowjs, routes, sockets
  expressApp = stubExpressApp()

stubExpressApp = ->
  middlewares: []
  settings: {}
  envs: {}
  configure: (env, fn) -> if fn? then @envs[env] = fn; fn() else env()
  use: (m) -> m? && @middlewares.push m; m
  set: (k, v) -> @settings[k] = v
  listen: (p) -> @listening = p



it 'should create app', ->

  $.when(express).createServer().thenReturn expressApp
  app.createServer().should.be.equal expressApp



it 'should use middlewares', ->

  expressMiddlewares = ['logger', 'bodyParser', 'cookieParser', 'methodOverride', 'compiler', 'static']
  stylusMiddleware = 'stylus'

  $.when(express).createServer().thenReturn expressApp
  $.when(express)[m]().thenReturn m for m in expressMiddlewares
  $.when(stylus).middleware().thenReturn stylusMiddleware

  app.createServer()
  app.use()

  expressApp.middlewares.should.contain m for m in expressMiddlewares
  expressApp.middlewares.should.contain stylusMiddleware



it 'should setup views', ->

  $.when(express).createServer().thenReturn expressApp

  app.createServer()
  app.views()

  expressApp.settings['views'].should.be.equal root '/views'
  expressApp.settings['view options'].layout.should.be.false
  expressApp.settings['view engine'].should.be.equal 'jade'



it 'should setup errorHandler by environment', ->

  expected = 'errorHandler'
  $.when(express).createServer().thenReturn expressApp
  $.when(express).errorHandler().thenReturn expected

  app.createServer()
  app.envs()

  expressApp.envs.development().should.be.equal expected
  expressApp.envs.production().should.be.equal expected



it 'should eject dependencies', ->

  ejected = {}
  initStub = {init: ->}
  $.when(express).createServer().thenReturn expressApp
  $.when(routes).inject(expressApp).thenCall -> ejected.routesApp = expressApp; initStub
  $.when(sockets).inject(expressApp, nowjs).thenCall ->
    ejected.socketsApp = expressApp
    ejected.socketsNowjs = nowjs
    initStub

  app.createServer()
  app.eject()

  ejected.routesApp.should.be.equal expressApp
  ejected.socketsApp.should.be.equal expressApp
  ejected.socketsNowjs.should.be.equal nowjs



it 'should listen on 3000', ->

  $.when(express).createServer().thenReturn expressApp

  app.createServer()
  app.listen()

  expressApp.listening.should.be.equal 3000