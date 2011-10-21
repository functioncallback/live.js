#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

app = undefined
root = (path) -> "#{__dirname}/..#{path}"

module.exports = inject: (express, stylus, nib, now, events, routes, sockets, watchers) ->

  init: ->
    @createServer()
    @configure()
    @envs()
    @events()
    @routes()
    @sockets()
    @listen()
    app

  createServer: ->
    app = express.createServer()

  configure: ->
    c = @
    app.configure ->
      c.use()
      c.views()

  use: ->
    app.use express.logger()
    app.use express.bodyParser()
    app.use express.cookieParser()
    app.use express.methodOverride()
    app.use stylus.middleware src: root('/public'), compile: (s, path) -> ((stylus s).set 'filename', path).use nib()
    app.use express.compiler src: root('/public'), enable: ['coffeescript']
    app.use express.static root '/public'
    app.use app.router

  views: ->
    app.set 'views', root '/views'
    app.set 'view options', layout: false
    app.set 'view engine', 'jade'

  envs: ->
    app.configure 'development', -> app.use express.errorHandler dumpExceptions: true, showStack: true
    app.configure 'production', -> app.use express.errorHandler()

  events: -> events.inject(watchers).init()
  routes: -> routes.inject(app, events).init()
  sockets: -> sockets.inject(app, now, watchers).init()

  listen: ->
    app.listen process.env.app_port or 3000