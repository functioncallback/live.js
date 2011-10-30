#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require('cappuccino').inject(module.exports)
stub = require './stubs/stub'
watchers = null

$.before ->
  watchers = require '../lib/watchers'
  watchers.length = 0



$.it 'should pull out a given watcher and return the updated count', ->

  w = stub.watcher()
  watchers.push w
  watchers.push stub.watcher()
  watchers.pull(w).should.be.equal(1)
  watchers.should.not.contain(w)



$.it 'should update watchers with a given event', ->

  e = 'some event'
  watchers.push stub.watcher() for n in [1..10]
  watchers.update(e)
  w.events.should.contain(e) for w in watchers