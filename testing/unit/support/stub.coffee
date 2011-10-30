#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

module.exports =

  root: (path) ->
    cut = '/testing/unit/support'
    "#{__dirname.substr(0, __dirname.length-cut.length)+'/lib/..'+path}"

  expressApp: ->
    middlewares: []
    settings: {}
    envs: {}
    configure: (env, fn) -> if fn? then @envs[env] = fn; fn() else env()
    use: (m) -> m? && @middlewares.push m; m
    set: (k, v) -> @settings[k] = v
    listen: (p) -> @listening = p

  everyone: (connections) ->
    connected: (callback) -> callback()
    disconnected: (callback) -> callback()
    now: count: (n) -> connections.active = n

  watcher: ->
    events: []
    update: (e) ->
      @events.push e

  watchers: ->
    stub = []
    stub.pull = (watcher) ->
      stub.splice (stub.indexOf watcher), 1
      stub.length
    stub