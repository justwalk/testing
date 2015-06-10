'use strict'

autoreplyPage = require '../pages/autoreply.coffee'
args = require '../../args.coffee'

describe 'autoreply page testing', ->
  beforeEach ->
    autoreplyPage.go()

  it 'should jump to tab of keyRule or defaultRule', ->
    autoreplyPage.keyRuleTab.click()
    expect(autoreplyPage.currentUrl).toEqual browser.baseUrl + autoreplyPage.keyRuleUrl
    autoreplyPage.defaultRuleTab.click()
    expect(autoreplyPage.currentUrl).toEqual browser.baseUrl + autoreplyPage.defaultRuleUrl

  it 'should jump to add new key rule url', ->
    autoreplyPage.goToAddkey()
    expect(autoreplyPage.currentUrl).toEqual browser.baseUrl + autoreplyPage.addKeyUrl

  it 'should add new key rule', ->
    autoreplyPage.sumRule.count()
    .then (count) ->
      autoreplyPage.addTextKeyRule(args.protractor.autoreply.ruleName, args.protractor.autoreply.key, args.protractor.autoreply.replayMessage)
      expect(autoreplyPage.sumRule.count()).toBe count + 1
