'use strict'

Page = require('astrolabe').Page

module.exports = Page.create
  url:
    value: '/channel/menu/555eda88e4b0b09dd54f46a1'

  addMainMenuItem:
    get: -> element @by.cssContainingText '.menu-add-content.ng-binding', '添加主菜单'

  addSubMenuItem:
    get: -> element @by.cssContainingText '.menu-add-content.ng-binding', '添加子菜单'

  menuNameInput:
    get: -> @find.by.css '.menu-value.form-control'

  clickActionText:
    get: -> @find.by.css '.menu-add-action'

  sendMessageItem:
    get: -> @find.by.css '.menu-click-icon'

  urlItem:
    get: -> @find.by.css '.menu-view-icon'

  VipCenterItem:
    get: -> @find.by.css '.menu-member-icon'

  sendMessageItemTextarea:
    get: -> element.all(@by.css('.message.message-text.form-control.ng-pristine.ng-valid')).get 1

  urlItemSelect:
    get: -> @find.by.css '.select-left.ng-binding'

  outSiteUrl:
    get: -> element.all(@by.css('.value-item.ng-binding.tooltipstered')).get 0

  inSiteUrl:
    get: -> element.all(@by.css('.value-item.ng-binding.tooltipstered')).get 1

  defaultHomePage:
    get: -> element.all(@by.css('.select-left.ng-binding')).get 1

  defaultHomePageSelect:
    get: -> element.all(@by.css('.value-item.ng-binding.tooltipstered')).get 3

  outSiteUrlContent:
    get: -> @find.by.css '.form-control.ng-isolate-scope.ng-pristine.ng-valid'

  createButton:
    get: -> @find.by.css '.btn.btn-primary.ng-binding.ng-scope'

  publicButton:
    get: -> @find.by.buttonText '发布'

  addedMenu:
    get: -> element.all(@by.css('.menu-item-name.ng-binding'))

  graphicTextIconButton:
    get: -> @find.by.css '.messageicon.messageicon-graphic.cp'

  graphicTextList:
    get: -> element.all(@by.css('.waterfall-news-detail-img-container.image-container')).get 1

  graphicTextSelectedButton:
    get: -> @find.by.css '.btn.btn-success.modal-btn-position.ng-scope'

  deleteMenuButton:
    get: -> element.all(@by.css('.icon.icon-delete'))

  submitDeleteMenuButton:
    get: -> @find.by.css '.btn-success.btn-operate-tag.btn-tag-ok'

  editButton:
    get: -> @find.by.css '.btn.btn-primary.ng-binding.ng-scope'


  addCustomMenu:               #send the plain text to users
    value: (menuName, outSiteUrl, subMenuName, message)->
      @addMainMenuItem.click()
      @menuNameInput.sendKeys menuName
      @clickActionText.click()
      @urlItem.click()
      @outSiteUrlContent.sendKeys outSiteUrl
      @createButton.click()
      @addSubMenuItem.click()
      @menuNameInput.sendKeys subMenuName
      @clickActionText.click()
      @sendMessageItem.click()
      @sendMessageItemTextarea.sendKeys message
      @createButton.click()
      @publicButton.click()
      browser.sleep 3000

  addCustomGraphicsMenu:      # send graphics and text to users
    value: (menuName, outSiteUrl, subMenuName) ->
      @addMainMenuItem.click()
      @menuNameInput.sendKeys menuName
      @clickActionText.click()
      @sendMessageItem.click()
      @graphicTextIconButton.click()
      @graphicTextList.click()
      @graphicTextSelectedButton.click()
      browser.sleep 3000
      @createButton.click()
      @addSubMenuItem.click()
      @menuNameInput.sendKeys subMenuName
      @clickActionText.click()
      @urlItem.click()
      @outSiteUrlContent.sendKeys outSiteUrl
      @createButton.click()
      @publicButton.click()
      browser.sleep 3000

  deleteMenu:
    value: (menuName) ->
      @addedMenu.count()
      .then (count) =>
        for i in [0...count]
          if i > 0
            @addedMenu.last().click()
            @deleteMenuButton.last().click()
            @submitDeleteMenuButton.click()
      .then =>
        @addedMenu.get(0).click()
        @editButton.click()
        @clickActionText.click()
        @sendMessageItem.click()
        @sendMessageItemTextarea.sendKeys menuName
        @createButton.click()
        @publicButton.click()
