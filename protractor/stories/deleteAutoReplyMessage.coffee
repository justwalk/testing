'use strict'

autoreplyPage = require '../pages/autoreply.coffee'

describe 'delete autoreply page message testing', ->
  beforeEach ->
    autoreplyPage.go()

  it 'should delete message', ->
    autoreplyPage.sumRule.count()
    .then (count) ->
      autoreplyPage.deleteMessage()
      expect(autoreplyPage.sumRule.count()).toBe count - 1
