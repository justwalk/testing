'use strict'

broadcastPage = require '../pages/broadcast.coffee'
addMessagePage = require '../pages/addMessage.coffee'
args = require '../../args.coffee'

describe 'send message to user  testing', ->
  beforeEach ->
    broadcastPage.go()

  it 'should jump to tabs of sentMessage or scheduleMessage', ->
    broadcastPage.sentMessageTab.click()
    expect(broadcastPage.currentUrl).toEqual  browser.baseUrl + broadcastPage.sentMessageUrl
    broadcastPage.scheduleMessageTab.click()
    expect(broadcastPage.currentUrl).toEqual  browser.baseUrl + broadcastPage.scheduleMessageUrl

  it 'should jump to addNewMessage page', ->
    broadcastPage.goToAddMessage()
    browser.sleep 2000
    expect(broadcastPage.currentUrl).toEqual browser.baseUrl + addMessagePage.url

  it 'should send message to custom', ->
    broadcastPage.sumMessage.count()
    .then (count)->
      addMessagePage.go()
      addMessagePage.addMessage args.protractor.sendMessageToUsers.type
      expect(broadcastPage.sumMessage.count()).toEqual count + 1
