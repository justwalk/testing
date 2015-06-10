'use strict'

graphicsPage = require '../pages/graphics.coffee'
addGraphicsPage = require '../pages/addGraphics.coffee'
args = require '../../args.coffee'

describe 'graphics text testing', ->
  beforeEach ->
    graphicsPage.go()

  it 'should jump to tabs of 全部,单图文，或多图文', ->
    graphicsPage.singleImageTextTab.click()
    expect(graphicsPage.currentUrl).toEqual browser.baseUrl + graphicsPage.singleImageTextUrl
    graphicsPage.multiImageTextTab.click()
    expect(graphicsPage.currentUrl).toEqual browser.baseUrl + graphicsPage.multiImageTextUrl
    graphicsPage.allTab.click()
    expect(graphicsPage.currentUrl).toEqual browser.baseUrl + graphicsPage.url

  it 'should appear selection Window', ->
    graphicsPage.clickAddIcon()
    browser.sleep 2000
    expect(graphicsPage.selectImageTextType.isPresent()).toBe true

  it 'should jump to addGraphics pages', ->
    graphicsPage.clickAddIcon()
    graphicsPage.singleImageTextOption.click()
    expect(graphicsPage.currentUrl).toEqual browser.baseUrl + addGraphicsPage.singleImageTextEditUrl
    graphicsPage.go()
    graphicsPage.clickAddIcon()
    graphicsPage.multiImageTextOption.click()
    expect(graphicsPage.currentUrl).toEqual browser.baseUrl + addGraphicsPage.multiImageTextEditUrl

  it 'should add message to page', ->
    browser.get browser.baseUrl + addGraphicsPage.singleImageTextEditUrl
    addGraphicsPage.addGraphicsContent args.protractor.graphicsContent.articleTitle,
        args.protractor.graphicsContent.imageFileUrl, args.protractor.graphicsContent.description,
        args.protractor.graphicsContent.mainText, args.protractor.graphicsContent.sourceUrl
    expect(graphicsPage.imageTextTitle.getText()).toEqual args.protractor.graphicsContent.articleTitle
