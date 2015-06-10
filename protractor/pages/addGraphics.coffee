'use strict'

Page = require('astrolabe').Page
path = require 'path'

module.exports = Page.create
  singleImageTextEditUrl:
    value: '/content/edit/graphics?active=0&type=0'

  multiImageTextEditUrl:
    value: '/content/edit/graphics?active=0&type=1'

  articleTitleInput:
    get: -> @find.by.model 'graphics.selectedGraphic.title'

  imageFileUrlInput:
    get: -> @find.by.css '.upload-mask.ng-isolate-scope.ng-valid.ng-dirty'

  descriptionTextArea:
    get: -> @find.by.model 'graphics.selectedGraphic.description'

  mainTextTextArea:
    get: -> element.all(@by.css('.view')).get(1)

  sourceUrlInput:
    get: -> @find.by.model 'graphics.selectedGraphic.sourceUrl'

  submitButton:
    get: -> @find.by.css '.btn.btn-primary'

  addGraphicsContent:
    value: (articleTitle, imageFileUrl, description, mainText, sourceUrl) ->
      @articleTitleInput.sendKeys articleTitle
      @imageFileUrlInput.sendKeys path.resolve(__dirname, imageFileUrl)
      @descriptionTextArea.sendKeys description
      @sourceUrlInput.sendKeys sourceUrl
      browser.switchTo().frame 'ueditor_0'
      isAngularSite false
      @mainTextTextArea.sendKeys mainText
      browser.switchTo().defaultContent()
      isAngularSite true
      browser.sleep 3000
      @submitButton.click()
      isAngularSite false
      browser.sleep 3000
