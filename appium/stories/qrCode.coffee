'use strict'

Asserter = require('wd').Asserter
driver = require '../lib/driver.coffee'
element = require '../lib/element.coffee'
args = require '../../args.coffee'

describe 'user scan QR code', ->
  this.timeout 10 * 60 * 1000

  before ->
    element
    .waitForIndex()

  it 'should receive message from server', ->
    element
    element.clickElement('发现')
    .then ->
      element.clickElement('扫一扫')
    .then ->
      driver.waitFor(new Asserter((target, cb) ->
        element
        .findElementInWechat(args.appium.qrCode.checkMessage)
        .should.eventually.exist
        .then (element) ->
          cb null, true , element
        .catch (err) ->
          cb false
        true
      ),300000)

  it 'should back to index page', ->
    element.clickBackButton()

