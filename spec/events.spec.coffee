#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

describe 'events', ->

  stub = require './support/stub'
  root = stub.root

  events = watchers = null



  beforeEach ->

    watchers = mock require root '/lib/watchers'
    events = require(root '/lib/events').inject watchers
    events.purge()



  it 'should schedule a job to publish events', ->

    e = id: 'event id'
    result = events.publish e
    interval = events.schedule()
    expect(interval.callback()).toContain result
    clearInterval interval



  it 'should publish an event', ->

    e = id: 'event id'
    published = undefined
    upon(watchers).update(match.any 'object').thenCall -> published = e
    expect(events.publish e).toBe 0
    expect(published).toBe e



  it 'should update an event', ->

    e = id: 'event id'
    events.update(e) for n in [1..10]
    expect(events.count e.id).toBe 10



  it 'should count a non-existent event as zero', ->

    expect(events.count 'non-existent').toBe 0



  it 'should purge events', ->

    events.update(id: "event #{n}") for n in [1..10]
    events.purge()
    expect(events.count "event #{n}").toBe 0 for n in [1..10]