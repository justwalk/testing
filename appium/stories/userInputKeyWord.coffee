'use strict'

driver = require '../lib/driver.coffee'
element = require '../lib/element.coffee'
args = require '../../args.coffee'
Asserter = require('wd').Asserter

describe 'user input key word testing', ->
  this.timeout 10 * 60 * 1000

  before ->
    element
    .waitForIndex()

  it 'official account should auto send message to custom', ->
    element
    .clickElement('通讯录')
    .then ->
      element.clickElement('公众号')
    .then ->
      element.clickElement('群脉SCRM')
    .then ->
      element.switchInputPanelInOfficialAccount()
    .then ->
      element.sendMessageToOfficialAccount(args.appium.userInputKeyWord.keyWord)
    .then ->
       driver.waitFor(new Asserter((target, cb) ->
        element
        .findElementInWechat(args.appium.userInputKeyWord.checkMessage)
        .should.eventually.exist
        .then (element) ->
          cb null, true , element
        .catch (err) ->
          cb false
        true
      ),300000)

  it 'should back to index page', ->
    element
    .clickBackButton()
    .then ->
      element.clickBackButton()
