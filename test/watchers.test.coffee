#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

require.paths.unshift("#{__dirname}/..");
watchers = null
should = require 'should'

it = (statement, callback) ->
  module.exports[statement] = ->
    beforeEach()
    callback()

beforeEach = ->
  watchers = require 'lib/watchers'
  watchers.length = 0

stubWatcher = ->
  events: []
  update: (e) ->
    @events.push e



it 'should pull out a given watcher and return the updated count', ->

  w = stubWatcher()
  watchers.push w
  watchers.push stubWatcher()
  watchers.pull(w).should.be.equal(1)
  watchers.should.not.contain(w)



it 'should update watchers with a given event', ->

  e = 'some event'
  watchers.push stubWatcher() for n in [1..10]
  watchers.update(e)
  w.events.should.contain(e) for w in watchers