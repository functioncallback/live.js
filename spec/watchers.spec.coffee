#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

describe 'watchers', ->

  stub = require './support/stub'
  root = stub.root

  watchers = null



  beforeEach ->

    watchers = require root '/lib/watchers'
    watchers.length = 0



  it 'should pull out a given watcher and return the updated count', ->

    w = stub.watcher()
    watchers.push w
    watchers.push stub.watcher()
    expect(watchers.pull w).toBe 1
    expect(watchers).not.toContain w



  it 'should update watchers with a given event', ->

    e = 'some event'
    watchers.push stub.watcher() for n in [1..10]
    watchers.update e
    expect(w.events).toContain e for w in watchers