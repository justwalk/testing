'use strict'

Asserter = require('wd').Asserter
driver = require '../lib/driver.coffee'
element = require '../lib/element.coffee'
args = require '../../args.coffee'

describe 'custom menu testing', ->
  this.timeout 10 * 60 * 1000

  before ->
    element
    .waitForIndex()

  it 'should exist custom menu', ->
    element
    .clickElement('通讯录')
    .then ->
      element.clickElement('公众号')
    .then ->
      element.clickElement('群脉SCRM')
    .then ->
      driver.waitFor(new Asserter((target, cb) ->
        element
        .findElementInWechat(args.appium.customizeMenu.mainMenu)
        .should.eventually.exist
        .then (element) ->
          cb null, true , element
        .catch (err) ->
          cb false
        true
      ),600000)

  it 'should back to index page', ->
    element
    .clickBackButton()
    .then ->
      element.clickBackButton()
