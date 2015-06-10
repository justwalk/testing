
customMenuPage = require '../pages/customMenu.coffee'
args = require '../../args.coffee'

describe 'custom menu testing', ->
  beforeEach ->
    customMenuPage.go()

  it 'should add custom menu', ->
    browser.waitForAngular()
    customMenuPage.addCustomGraphicsMenu(args.protractor.customMenu.menuName, args.protractor.customMenu.outSiteUrl,
        args.protractor.customMenu.subMenuName)
