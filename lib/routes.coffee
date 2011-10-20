#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

module.exports = inject: (app) ->

  init: ->
    @index()

  index: ->
    app.get '/', (req, res) ->
      res.render 'index'