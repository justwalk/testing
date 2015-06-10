
customMenuPage = require '../pages/customMenu.coffee'
args = require '../../args.coffee'

describe 'custom menu testing', ->
  beforeEach ->
    customMenuPage.go()

  it 'should add custom menu', ->
    browser.waitForAngular()
    customMenuPage.deleteMenu(args.protractor.customMenu.menuName)
    browser.waitForAngular()
    expect(customMenuPage.addedMenu.count()).toBe 1
