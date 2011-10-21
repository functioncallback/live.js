#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

root = (path) -> "#{__dirname.substr(0, __dirname.length-5)}/lib/..#{path}"
require.paths.unshift("#{__dirname}/..");
app = express = expressApp = stylus = nib = now = events = routes = sockets = watchers = null
should = require 'should'
$ = require 'mock.js'

it = (statement, callback) ->
  module.exports[statement] = ->
    beforeEach()
    callback()

beforeEach = ->
  express  = $.mock require 'express'
  stylus   = $.mock require 'stylus'
  nib      = $.mock require 'nib'
  now      = $.mock require 'now'
  events   = $.mock require 'lib/events'
  routes   = $.mock require 'lib/routes'
  sockets  = $.mock require 'lib/sockets'
  watchers = ['watcher']
  app = require('lib/app').inject express, stylus, nib, now, events, routes, sockets, watchers
  expressApp = stubExpressApp()

stubExpressApp = ->
  middlewares: []
  settings: {}
  envs: {}
  configure: (env, fn) -> if fn? then @envs[env] = fn; fn() else env()
  use: (m) -> m? && @middlewares.push m; m
  set: (k, v) -> @settings[k] = v
  listen: (p) -> @listening = p



it 'should create express app server', ->

  $.when(express).createServer().thenReturn expressApp
  app.createServer().should.be.equal expressApp



it 'should use middlewares', ->

  expressMiddlewares = ['logger', 'bodyParser', 'cookieParser', 'methodOverride', 'compiler', 'static']
  stylusMiddleware = 'stylus'
  expressRouter = 'router'

  expressApp.router = expressRouter
  $.when(express).createServer().thenReturn expressApp
  $.when(express)[m]().thenReturn m for m in expressMiddlewares
  $.when(stylus).middleware().thenReturn stylusMiddleware

  app.createServer()
  app.use()

  expressApp.middlewares.should.contain m for m in expressMiddlewares
  expressApp.middlewares.should.contain stylusMiddleware
  expressApp.middlewares.should.contain expressRouter



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



it 'should inject dependencies into events module', ->

  ejected = {}
  $.when(express).createServer().thenReturn expressApp
  $.when(events).inject(watchers).thenCall ->
    ejected.events = watchers: watchers
    {init: ->}

  app.createServer()
  app.events()

  ejected.events.watchers.should.be.equal watchers



it 'should inject dependencies into routes module', ->

  ejected = {}
  $.when(express).createServer().thenReturn expressApp
  $.when(routes).inject(expressApp, events).thenCall ->
    ejected = expressApp: expressApp, events: events
    {init: ->}

  app.createServer()
  app.routes()

  ejected.expressApp.should.be.equal expressApp
  ejected.events.should.be.equal events



it 'should inject dependencies into sockets module', ->

  ejected = {}
  $.when(express).createServer().thenReturn expressApp
  $.when(sockets).inject(expressApp, now, watchers).thenCall ->
    ejected = expressApp: expressApp, now: now, watchers: watchers
    {init: ->}

  app.createServer()
  app.sockets()

  ejected.expressApp.should.be.equal expressApp
  ejected.now.should.be.equal now
  ejected.watchers.should.be.equal watchers



it 'should listen on 3000', ->

  $.when(express).createServer().thenReturn expressApp

  app.createServer()
  app.listen()

  expressApp.listening.should.be.equal 3000