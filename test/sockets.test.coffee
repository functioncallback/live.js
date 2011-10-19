require.paths.unshift("#{__dirname}/..");

it = module.exports
should = require 'should'
$ = require 'mock.js'

app = $.mock require('express').createServer()
nowjs = $.mock require('now')

sockets = require('lib/sockets').inject(app, nowjs)



it['should initialize sockets'] = ->

  