#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

module.exports = inject: (app, events) ->

  init: ->
    @index()
    @nowjs()
    @event()

  index: ->
    app.get '/', (req, res) ->
      res.render 'index'

  nowjs: ->
    app.get '/javascripts/third-party/now.js', (req, res) ->
      res.redirect '/nowjs/now.js'

  event: ->
    app.post '/event', (req, res) ->
      events.update req.body if req.body
      res.send ''