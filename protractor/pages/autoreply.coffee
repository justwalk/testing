'use strict'

Page = require('astrolabe').Page
protractor = require 'protractor'
args = require '../../args.coffee'

module.exports = Page.create
  url:
    value: '/channel/autoreply/555eda88e4b0b09dd54f46a1'

  keyRuleUrl:
    value: '/channel/autoreply/555eda88e4b0b09dd54f46a1?active=0'

  defaultRuleUrl:
    value: '/channel/autoreply/555eda88e4b0b09dd54f46a1?active=1'

  addKeyUrl:
    value: '/channel/edit/autoreply/555eda88e4b0b09dd54f46a1'

  keyRuleTab:
    get: -> element.all(@by.css('.tab.ng-binding.ng-scope')).get 0

  defaultRuleTab:
    get: -> element.all(@by.css('.tab.ng-binding.ng-scope')).get 1

  initAddKeyButton:
    get: -> element @by.css '.keywordlist-zero-img.center-block'

  addkeyButton:
    get: -> element @by.css '.btn.btn-success.keywordlist-new-btn.fr.ng-binding'

  ruleNameInput:
    get: -> element @by.css '.form-control.keyword-rule-text.ng-pristine.ng-valid'

  keyInput:
    get: -> element @by.css '.form-control.keyword-key-text.w410.ng-pristine.ng-valid'

  keyMatchDropDownList:
    get: -> element @by.css '.select-left.ng-binding'

  keyMatchDropDownListItem:
    get: -> element(@by.css('.select-dropdown')).all @by.tagName 'li'

  replayMessage:
    get: -> element.all(@by.css('.message.message-text.form-control.ng-pristine.ng-valid')).get(1)

  submitButton:
    get: -> element @by.css '.btn.btn-success.fl.ng-binding'

  sumRule:
    get: -> element.all(@by.tagName('tbody')).get(0).all(@by.tagName('tr'))

  addedRuleName:
    get: -> element @by.cssContainingText('.ng-binding.ng-scope', args.protractor.autoreply.ruleName)

  deleteMessageButton:
    get: -> element.all(@by.css('.operate-icon.delete-icon')).get 0

  deleteMessageSubmitButton:
    get: -> element @by.css '.btn-success.btn-operate-tag'

  deleteMessage:
    value: ->
      @deleteMessageButton.click()
      @deleteMessageSubmitButton.click()

  graphicTextIconButton:
    get: -> @find.by.css '.messageicon.messageicon-graphic.cp'

  graphicTextList:
    get: -> element.all(@by.css('.waterfall-news-detail-img-container.image-container')).get 1

  graphicTextSelectedButton:
    get: -> element @by.css '.btn.btn-success.modal-btn-position.ng-scope'

  goToAddkey:
    value: ->
      protractor.promise.filter [@initAddKeyButton, @addkeyButton], (button) ->
        button.isDisplayed()
      .then (buttons) ->
        buttons[0].click()

  addTextKeyRule:
    value: (ruleName, key, replayMessage) ->
      @goToAddkey()
      @ruleNameInput.sendKeys ruleName
      @keyInput.sendKeys key
      @keyMatchDropDownList.click()
      @keyMatchDropDownListItem.get(0).click()
      @replayMessage.sendKeys replayMessage
      @submitButton.click()

  addGraphicsKeyRule:
    value: (ruleName, key) ->
      @goToAddkey()
      @ruleNameInput.sendKeys ruleName
      @keyInput.sendKeys key
      @graphicTextIconButton.click()
      @graphicTextList.click()
      @graphicTextSelectedButton.click()
      browser.sleep 3000
      @submitButton.click()
