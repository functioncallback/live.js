#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require('cappuccino').inject(module.exports)
events = watchers = null

$.before ->
  watchers = $.mock require '../lib/watchers'
  events = require('../lib/events').inject watchers
  events.purge()



$.it 'should schedule a job to publish events', ->

  e = id: 'event id'
  result = events.publish(e)
  interval = events.schedule()
  interval.callback().should.contain result
  clearInterval interval



$.it 'should publish an event', ->

  e = id: 'event id'
  published = undefined
  $.when(watchers).update($.any 'object').thenCall -> published = e
  events.publish(e).should.be.equal(0)
  published.should.be.equal(e)



$.it 'should update an event', ->

  e = id: 'event id'
  events.update(e) for n in [1..10]
  events.count(e.id).should.be.equal(10)



$.it 'should count a non-existent event as zero', ->

  events.count('non-existent').should.be.equal(0)



$.it 'should purge events', ->

  events.update(id: "event #{n}") for n in [1..10]
  events.purge()
  events.count("event #{n}").should.be.equal(0) for n in [1..10]