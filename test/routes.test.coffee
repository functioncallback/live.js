require.paths.unshift("#{__dirname}/..");

it = module.exports
should = require 'should'
$ = require 'mock.js'

app = $.mock require('express').createServer()

routes = require('lib/routes').inject(app)



it['should route to index page'] = ->

  