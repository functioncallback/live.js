#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

module.exports = inject: (testModuleExports) ->

  api = require 'mock.js'
  api.should = require 'should'
  api.stub = require './stub'
  before = undefined

  api.it = (statement, callback) ->
    testModuleExports[statement] = ->
      before?()
      callback()

  api.before = (b) ->
    before = b

  api.root = (path) ->
    "#{__dirname.substr(0, __dirname.length-13)}/lib/..#{path}"

  api