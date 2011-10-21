/*
 * live.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

require.paths.unshift(__dirname);
require('coffee-script');
require('lib/app').inject(
  require('express')
 ,require('stylus')
 ,require('nib')
 ,require('now')
 ,require('lib/events')
 ,require('lib/routes')
 ,require('lib/sockets')
 ,require('lib/watchers')
).init();