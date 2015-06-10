'use strict'

Page = require('astrolabe').Page
protractor = require 'protractor'

module.exports = Page.create
  url:
    value: '/management/channel'

  initAddWeiboButton:
    get: -> element @by.cssContainingText '.channel-unbind-info', '暂未添加微博账号'

  addWeiboButton:
    get: -> @find.by.buttonText '添加微博账号'

  initAddWeixinButton:
    get: -> element @by.cssContainingText '.channel-unbind-info', '暂未添加微信公众号'

  addWeixinButton:
    get: -> @find.by.buttonText '添加微信公众号'

  clickAddWeiboButton:
    value: ->
      protractor.promise.filter [@initAddWeiboButton, @addWeiboButton], (button) ->
        button.isDisplayed()
      .then (buttons) ->
        buttons[0].click()

  clickAddWeixinButton:
    value: ->
      protractor.promise.filter [@initAddWeixinButton, @addWeixinButton], (button) ->
        button.isDisplayed()
      .then (buttons) ->
        buttons[0].click()
