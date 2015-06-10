'use strict'

Asserter = require('wd').Asserter
driver = require '../lib/driver.coffee'
element = require '../lib/element.coffee'
args = require '../../args.coffee'

describe 'follow official account testing', ->
  this.timeout 10 * 60 * 1000

  before ->
    element
    .waitForIndex()

  it 'should follow official account', ->
    element
    .clickElement('通讯录')
    .then ->
      element.clickElement('公众号')
    .then ->
      element
      .addOfficialAccount(args.appium.followOfficialAccount.ID, args.appium.followOfficialAccount.name)
      .then ->
        driver.waitFor(new Asserter((target, cb)->
          element
          .findElementInWechat(args.appium.followOfficialAccount.checkMessage)
          .should.eventually.exist
          .then (ele) ->
            cb null, true, ele
          .catch (err) ->
            cb false
          true
        ), 3000)
      .then ->
        element.clickBackButton()
