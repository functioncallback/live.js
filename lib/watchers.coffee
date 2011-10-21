#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

watchers = module.exports = []

watchers.pull = (watcher) ->
  watchers.splice (watchers.indexOf watcher), 1
  watchers.length

watchers.update = (event) ->
  watcher.update event for watcher in watchers