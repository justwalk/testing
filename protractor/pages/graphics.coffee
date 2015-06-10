'use strict'

Page = require('astrolabe').Page
protractor = require 'protractor'

module.exports = Page.create
  url:
    value: '/content/graphics?active=0'

  singleImageTextUrl:
    value: '/content/graphics?active=1'

  multiImageTextUrl:
    value: '/content/graphics?active=2'

  allTab:
    get: -> element @by.cssContainingText '.tab.ng-binding.ng-scope', '全部'

  singleImageTextTab:
    get: -> element @by.cssContainingText '.tab.ng-binding.ng-scope', '单图文'

  multiImageTextTab:
    get: -> element @by.cssContainingText '.tab.ng-binding.ng-scope', '多图文'

  initAddIcon:
    get: -> element @by.css '.add-icon.cp'

  addIcon:
    get: -> element @by.css '.btn.btn-success.btn-position.btn-add-icon.ng-scope'

  selectImageTextType:
    get: -> element @by.cssContainingText '.modal-title.create-graphics-title.ng-binding', '选择图文类型'

  singleImageTextOption:
    get: -> @find.by.css '.single-panel.graphics-font.cp'

  multiImageTextOption:
    get: -> @find.by.css '.multiple-panel.graphics-font.cp'

  imageTextTitle:
    get: -> @find.by.css '.waterfall-news-detail-title.ng-binding'

  deleteGraphicsButton:
    get: -> element.all(@by.css('.delete-icon-style.cp')).get 0

  deleteSubmitButton:
    get: -> @find.by.css '.btn-success.btn-operate-tag'

  sumItemGraphics:
    get: -> element.all(@by.css('.waterfall-item.waterfall-width'))

  deleteGraphics:
    value: ->
      @deleteGraphicsButton.click()
      @deleteSubmitButton.click()

  clickAddIcon:
    value: ->
      protractor.promise.filter [@initAddIcon, @addIcon], (button) ->
        button.isPresent()
      .then (buttons) ->
        buttons[0].click()
