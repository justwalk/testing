
'use strict'

Asserter = require('wd').Asserter
driver = require '../lib/driver.coffee'
element = require '../lib/element.coffee'
args = require '../../args.coffee'

describe 'receive message testing', ->
  this.timeout 10 * 60 * 1000

  before ->
    element
    .waitForIndex()

  it 'should exist receiving message from  officail Account', ->
    element
    .clickElement('通讯录')
    .then ->
      element.clickElement('公众号')
    .then ->
      element.clickElement('群脉SCRM')
    .then ->
      driver.waitFor(new Asserter((target, cb)->
        element
        .findElementInWechat(args.appium.receiveMessage.checkMessage)
        .should.eventually.exist
        .then (ele) ->
          cb null, true, ele
        .catch (err) ->
          cb false
        true
      ), 300000)

  it 'should back to index page', ->
    element
    .clickBackButton()
    .then ->
      element.clickBackButton()
