'use strict'

driver = require './driver.coffee'

module.exports =
  waitForIndex: ->
    driver.waitForElementById 'com.tencent.mm:id/dl', 1 * 60 * 1000, (err, element) ->
      if err
        console.error 'wait for index error', err

  clickBackButton: ->
    driver.elementByName('返回').click()

  clickElement: (text) ->
    driver.elementByXPath("//android.widget.TextView[contains(@text, '#{ text }')]").click()

  findElementInWechat: (text) ->
    driver.elementByXPath("//android.widget.TextView[contains(@text, '#{ text }')]")

  switchInputPanelInOfficialAccount: ->
    driver.elementById('com.tencent.mm:id/tx').click()

  sendMessageToOfficialAccount: (text) ->
    driver
    .elementById('com.tencent.mm:id/tl').sendKeys text
    .elementById('com.tencent.mm:id/tr').click()

  addOfficialAccount: (officialID, officialName)->
    driver
    .elementByName('添加').click()
    .elementByXPath("//android.widget.EditText[contains(@text, '查找公众号')]").sendKeys officialID
    .elementByXPath("//android.widget.Button[contains(@text, '搜索')]").click()
    .waitForElementByXPath "//android.widget.TextView[contains(@text, '#{ officialName }')]", 1 * 60 * 1000, (err, element) ->
      if element
        element.click()
    .sleep 2000
    .elementByXPath("//android.widget.TextView[contains(@text, '关注')]").click()
    .catch ->
      driver
      .elementByName('更多').click()
      .waitForElementByXPath "//android.widget.TextView[contains(@text, '不再关注')]", 1*60*1000, (err, element) ->
        if element
          element.click()
        else
          console.error err
      .waitForElementByXPath "//android.widget.Button[contains(@text, '不再关注')]", 1 * 60 * 1000, (err, element) ->
        if element
          element.click()
        else
          console.error err
      .waitForElementByXPath "//android.widget.TextView[contains(@text, '#{ officialName }')]", 1 * 60 * 1000, (err, element) ->
        if element
          element.click()
        else
          console.error err
      .sleep 2000
      .elementByXPath("//android.widget.TextView[contains(@text, '关注')]").click()


  unfollowOfficialAccountInfo: ->
    driver
    .elementByName('聊天信息').click()
    .elementByName('更多').click()
    .waitForElementByXPath "//android.widget.TextView[contains(@text, '不再关注')]", 1 * 60 * 1000, (err, element) ->
      if element
        element.click()
      else
        console.error err
    .sleep 2000
    .elementByXPath("//android.widget.Button[contains(@text, '不再关注')]").click()
