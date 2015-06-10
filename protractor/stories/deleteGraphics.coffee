'use strict'
graphicsPage = require '../pages/graphics.coffee'

describe 'delete graphics text testing', ->
  beforeEach ->
    graphicsPage.go()

  it 'should delete graphics text', ->
    browser.waitForAngular()
    graphicsPage.sumItemGraphics.count()
    .then (count) ->
      graphicsPage.deleteGraphics()
      expect(graphicsPage.sumItemGraphics.count()).toBe count - 1
