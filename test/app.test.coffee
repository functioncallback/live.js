require.paths.unshift("#{__dirname}/..");

it = module.exports
should = require 'should'
$ = require 'mock.js'

express = $.mock require 'express'
stylus = $.mock require 'stylus'
nib = $.mock require 'nib'
nowjs = $.mock require 'now'
routes = $.mock require 'lib/routes'
sockets = $.mock require 'lib/sockets'

expectedApp =
  middlewares: []
  settings: {}
  configure: (env, callback) -> if callback? then callback() else env()
  use: (middleware) -> middleware? && @middlewares.push middleware
  set: (key, value) -> @settings[key] = value
  listen: (port) -> @listening = port

actualApp = ->
  require('lib/app').inject(express, stylus, nib, nowjs, routes, sockets)



it['should create app server'] = ->

  $.when(express).createServer().thenReturn(expectedApp)
  app = actualApp()
  app.should.be.equal expectedApp



it['should use express logger middleware'] = ->

  $.when(express).logger().thenReturn 'logger'
  app = actualApp()
  app.middlewares.should.contain 'logger'



it['should use express bodyParser middleware'] = ->

  $.when(express).bodyParser().thenReturn 'bodyParser'
  app = actualApp()
  app.middlewares.should.contain 'bodyParser'



it['should use express cookieParser middleware'] = ->

  $.when(express).cookieParser().thenReturn 'cookieParser'
  app = actualApp()
  app.middlewares.should.contain 'cookieParser'



it['should use express methodOverride middleware'] = ->

  $.when(express).methodOverride().thenReturn 'methodOverride'
  app = actualApp()
  app.middlewares.should.contain 'methodOverride'



it['should use express compiler middleware'] = ->

  $.when(express).compiler().thenReturn 'compiler'
  app = actualApp()
  app.middlewares.should.contain 'compiler'



it['should use express static middleware'] = ->

  $.when(express).static().thenReturn 'static'
  app = actualApp()
  app.middlewares.should.contain 'static'



it['should use express errorHandler middleware'] = ->

  $.when(express).errorHandler().thenReturn 'errorHandler'
  app = actualApp()
  app.middlewares.should.contain 'errorHandler'



it['should use stylus middleware'] = ->

  $.when(stylus).middleware().thenReturn 'stylus middleware'
  app = actualApp()
  app.middlewares.should.contain 'stylus middleware'



it['should inject app into routes module'] = ->

  injected = {}
  $.when(routes).inject(expectedApp).thenCall -> injected.app = expectedApp
  app = actualApp()
  injected.app.should.be.equal expectedApp



it['should inject app and nowjs into sockets module'] = ->

  injected = {}
  $.when(sockets).inject(expectedApp, nowjs).thenCall ->
    injected.app = expectedApp
    injected.nowjs = nowjs
  app = actualApp()
  injected.app.should.be.equal expectedApp
  injected.nowjs.should.be.equal nowjs



it['should listen on port 3000'] = ->

  app = actualApp()
  app.listening.should.be.equal 3000