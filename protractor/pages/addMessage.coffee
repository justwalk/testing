'use strict'

Page = require('astrolabe').Page

module.exports = Page.create
  url:
    value: '/channel/edit/broadcast/555eda88e4b0b09dd54f46a1'

  objectDropDownList:
    get: -> element.all(@by.css('.select-left.ng-binding')).get 0

  objectDropDownListOption:
    get: -> element.all(@by.css('.select.fs12.ng-isolate-scope.ng-pristine.ng-valid')).get(0).all @by.tagName 'li'

  objectTagInput:
    get: -> @find.by.css '.autodropdown-tags'

  objectTagInputList:
    get: -> element(@by.css('.autodropdown-items.ng-scope')).all(@by.tagName('li'))

  genderDropDownList:
    get: -> element.all(@by.css('.select-left.ng-binding')).get 1

  genderDropDownListOption:
    get: -> element.all(@by.css('.select-dropdown')).get(1).all(@by.tagName('li'))

  areaDropDownList:
    get: -> element.all(@by.css('.select-left.ng-binding')).get 2

  areaDropDownListOption:
    get: -> element.all(@by.css('.select-dropdown')).get(2).all(@by.tagName('li'))

  contentTextArea:
    get: -> element.all(@by.model('textMessage')).get 1

  submitButtton:
    get: -> @find.by.css '.btn.btn-success.mr20.user-btn'

  cancelButtton:
    get: -> @find.by.css '.btn.btn-default.user-btn.ng-binding'

  graphicTextIconButton:
    get: -> @find.by.css '.messageicon.messageicon-graphic.cp'

  graphicTextSelect:
    get: -> element.all(@by.css('.news-wrap.cp')).all(@by.css '.waterfall-news-list-cover').get 0

  graphicTextList:
    get: -> element.all(@by.css('.waterfall-news-detail-img-container.image-container')).get 1

  graphicTextSelectedButton:
    get: -> @find.by.css '.btn.btn-success.modal-btn-position.ng-scope'

  addMessage:
    value: (type) ->
      if type == 'Part'
        @objectDropDownList.click()
        @objectDropDownListOption.get(1).click()
        @objectTagInput.click()
        @objectTagInputList.last().click()
      else
        @objectDropDownList.click()
        @objectDropDownListOption.get(0).click()
        @genderDropDownList.click()
        @genderDropDownListOption.get(0).click()
        @areaDropDownList.click()
        @areaDropDownListOption.get(0).click()
      @graphicTextIconButton.click()
      @graphicTextList.click()
      @graphicTextSelectedButton.click()
      browser.sleep 3000
      @submitButtton.click()
