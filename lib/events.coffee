#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

module.exports = inject: (watchers) ->

  api = @
  events = {}

  init: ->
    @schedule()
    api.update = @update

  schedule: ->
    publish = @publish
    setInterval (->
      publish id for id of events
    ), 1000

  publish: (id) ->
    watchers.update
      id: id
      x: Date.now()
      y: events[id]
    events[id] = 0

  update: (e) ->
    events[e.id] = events[e.id] or 0
    events[e.id]++

  count: (id) ->
    events[id] or 0

  purge: ->
    events = {}