http = require 'http'
Buffer = require('buffer').Buffer
debug = require('debug')('node-baidu-ping')

exports = module.exports = (title, urls)->
  body = build_body title, urls
  debug 'body', body

  # Prepare request
  options =
    host: 'ping.baidu.com',
    path: '/ping/RPC2',
    port: 80,
    method: "POST",
    headers:
      'Content-Type': 'text/xml',
      'User-Agent': 'request'
      'Content-Length': Buffer.byteLength body

  # Make request
  req = http.request options, (res)->
    debug 'response status code', res.statusCode
    buffer = ''
    res.on 'data', (data)->
      buffer += data;
    res.on 'end', ()->
      debug 'response', buffer

  req.write body
  req.end()

build_body = (title, urls)->
  body = []
  body.push '<?xml version="1.0" encoding="UTF-8"?>'
  body.push '<methodCall>'
  body.push '<methodName>weblogUpdates.extendedPing</methodName>'
  body.push '<params>'
  body.push "<param><value><string>#{title}</string></value></param>"
  body.push "<param><value><string>#{url}</string></value></param>" for url in urls
  body.push '</params>'
  body.push '</methodCall>'
  body.join ''
