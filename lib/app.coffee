module.exports = inject: (express, stylus, nib, nowjs, routes, sockets) ->

  app = express.createServer()
  root = (path) -> "#{__dirname}/..#{path}"
  stylusCompiler = (str, path) ->
    (((stylus str)
    .set 'filename', path)
    .use nib())

  app.configure ->
    app.use app.router
    app.use express.logger()
    app.use express.bodyParser()
    app.use express.cookieParser()
    app.use express.methodOverride()
    app.use stylus.middleware src: root('/public'), compile: stylusCompiler
    app.use express.compiler src: root('/public'), enable: ['coffeescript']
    app.use express.static root '/public'
    app.set 'views', root '/views'
    app.set 'view options', layout: false
    app.set 'view engine', 'jade'

  app.configure 'development', -> app.use express.errorHandler dumpExceptions: true, showStack: true
  app.configure 'production', -> app.use express.errorHandler()

  routes.inject app
  sockets.inject app, nowjs
  app.listen process.env.app_port or 3000
  app