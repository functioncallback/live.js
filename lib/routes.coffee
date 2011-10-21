#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

module.exports = inject: (app, events) ->

  init: ->
    @index()
    @event()

  index: ->
    app.get '/', (req, res) ->
      res.render 'index'

  event: ->
    app.post '/event', (req, res) ->
      events.update req.body
      res.send ''