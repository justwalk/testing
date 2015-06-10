'use strict'

interactionPage = require '../pages/interaction.coffee'
params = require '../params.coffee'

describe 'interaction with user testing', ->
  beforeEach ->
    interactionPage.go()

  it 'should jump to tabs of AllMessage,todayMessage,yesterdayMessage,beforeYesterdayMessage,earlierMessage', ->
    interactionPage.AllMessageTab.click()
    expect(interactionPage.currentUrl).toEqual browser.baseUrl + interactionPage.AllMessageTabUrl
    interactionPage.todayMessageTab.click()
    expect(interactionPage.currentUrl).toEqual browser.baseUrl + interactionPage.todayMessageTabUrl
    interactionPage.yesterdayMessageTab.click()
    expect(interactionPage.currentUrl).toEqual browser.baseUrl + interactionPage.yesterdayMessageTabUrl
    interactionPage.beforeYesterdayMessageTab.click()
    expect(interactionPage.currentUrl).toEqual browser.baseUrl + interactionPage.beforeYesterdayMessageTabUrl
    interactionPage.earlierMessageTab.click()
    expect(interactionPage.currentUrl).toEqual browser.baseUrl + interactionPage.earlierMessageTabUrl

  it 'should receive message from user', ->
    expect(interactionPage.userReplyContent.getText()).toEqual params.interactionWithUser.receiveMessage

  it 'should reply to user', ->
    interactionPage.interactionWithUser params.interactionWithUser.index, params.interactionWithUser.sendMessage
