#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

describe 'app', ->

  stub = require './support/stub'
  root = stub.root

  app = express = expressApp = stylus = nib = now = events = routes = sockets = watchers = null



  beforeEach ->

    expressApp = stub.expressApp()
    events   = mock require root '/lib/events'
    routes   = mock require root '/lib/routes'
    sockets  = mock require root '/lib/sockets'
    express  = mock require 'express'
    now      = mock require 'now'
    stylus   = mock middleware: require('stylus').middleware
    nib      = require 'nib'
    watchers = ['one']
    app = require(root '/lib/app').inject express, stylus, nib, now, events, routes, sockets, watchers



  it 'should create express app server', ->

    upon(express).createServer().thenReturn expressApp
    expect(app.createServer()).toEqual expressApp



  it 'should use middlewares', ->

    expressMiddlewares = ['logger', 'bodyParser', 'cookieParser', 'methodOverride', 'compiler', 'static']
    stylusMiddleware = 'stylus'
    expressRouter = 'router'

    expressApp.router = expressRouter
    upon(express).createServer().thenReturn expressApp
    upon(express)[m]().thenReturn m for m in expressMiddlewares
    upon(stylus).middleware().thenReturn stylusMiddleware

    app.createServer()
    app.use()

    expect(expressApp.middlewares).toContain m for m in expressMiddlewares
    expect(expressApp.middlewares).toContain stylusMiddleware
    expect(expressApp.middlewares).toContain expressRouter



  it 'should setup views', ->

    upon(express).createServer().thenReturn expressApp

    app.createServer()
    app.views()

    expect(expressApp.settings['views']).toBe root '/views'
    expect(expressApp.settings['view options'].layout).toBeFalsy()
    expect(expressApp.settings['view engine']).toBe 'jade'



  it 'should setup errorHandler by environment', ->

    expected = 'errorHandler'
    upon(express).createServer().thenReturn expressApp
    upon(express).errorHandler().thenReturn expected

    app.createServer()
    app.envs()

    expect(expressApp.envs.development()).toBe expected
    expect(expressApp.envs.production()).toBe expected



  it 'should inject dependencies into events module', ->

    ejected = {}
    upon(express).createServer().thenReturn expressApp
    upon(events).inject(watchers).thenCall ->
      ejected.events = watchers: watchers
      {init: ->}

    app.createServer()
    app.events()

    expect(ejected.events.watchers).toBe watchers



  it 'should inject dependencies into routes module', ->

    ejected = {}
    upon(express).createServer().thenReturn expressApp
    upon(routes).inject(expressApp, events).thenCall ->
      ejected = expressApp: expressApp, events: events
      {init: ->}

    app.createServer()
    app.routes()

    expect(ejected.expressApp).toBe expressApp
    expect(ejected.events).toBe events



  it 'should inject dependencies into sockets module', ->

    ejected = {}
    upon(express).createServer().thenReturn expressApp
    upon(sockets).inject(expressApp, now, watchers).thenCall ->
      ejected = expressApp: expressApp, now: now, watchers: watchers
      {init: ->}

    app.createServer()
    app.sockets()

    expect(ejected.expressApp).toBe expressApp
    expect(ejected.now).toBe now
    expect(ejected.watchers).toBe watchers



  it 'should listen on 3000', ->

    upon(express).createServer().thenReturn expressApp

    app.createServer()
    app.listen()

    expect(expressApp.listening).toBe 3000