'use strict'

driver = require '../lib/driver.coffee'
element = require '../lib/element.coffee'

describe 'unfollow official account testing', ->
  this.timeout 10 * 60 * 1000

  before ->
    element
    .waitForIndex()

  it 'should unfollow official account', ->
    element
    .clickElement('通讯录')
    .then ->
      element.clickElement('公众号')
    .then ->
      element.clickElement('群脉SCRM')
    .then ->
      element.unfollowOfficialAccountInfo()
