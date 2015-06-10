'use strict'

driver = require '../lib/driver.coffee'
element = require '../lib/element.coffee'
params = require '../params.coffee'
Asserter = require('wd').Asserter

describe 'Official account', ->
  this.timeout 10 * 60 * 1000

  before ->
    element
    .waitForIndex()

  it 'should receive message', ->
    element
    .clickElement('通讯录')
    .then ->
      element.clickElement('公众号')
    .then ->
      element.clickElement('群脉SCRM')
    .then ->
      element.switchInputPanelInOfficialAccount()
    .then ->
      element.sendMessageToOfficialAccount(params.sendMessageToServer.content)
    .then ->
      driver.waitFor(new Asserter((target, cb) ->
        element
        .findElementInWechat(params.sendMessageToServer.checkMessage)
        .should.eventually.exist
        .then (element) ->
          cb null, true , element
        .catch (err) ->
          cb false
        true
      ),300000)

  it 'wechat should back to index page', ->
    element
    .clickBackButton()
    .then ->
      element.clickBackButton()
