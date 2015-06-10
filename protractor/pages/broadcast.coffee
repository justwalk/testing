'use strict'

Page = require('astrolabe').Page
protractor = require 'protractor'

module.exports = Page.create
  url:
    value: '/channel/broadcast/555eda88e4b0b09dd54f46a1'

  sentMessageUrl:
    value: '/channel/broadcast/555eda88e4b0b09dd54f46a1?active=0'

  scheduleMessageUrl:
    value: '/channel/broadcast/555eda88e4b0b09dd54f46a1?active=1'

  initAddKeyButton:
    get: -> element @by.css '.menber-create-icon.center-block.cp'

  addNewMessageButton:
    get: -> element @by.css '.btn.btn-success.broadcast-new-btn.pull-right.ng-binding.ng-scope'

  sentMessageTab:
    get: -> element @by.cssContainingText '.tab.ng-binding.ng-scope', '已发送'

  scheduleMessageTab:
    get: -> element @by.cssContainingText '.tab.ng-binding.ng-scope', '定时发送'

  sentMessage:
    get: -> element.all(@by.css('.fs14.broadcast-title.ng-binding.ng-scope')).get 0

  sumMessage:
    get: -> element.all(@by.repeater('item in broadcast.list'))

  goToAddMessage:
    value: ->
      # FIXME: Failed with 'No element found'
      protractor.promise.filter [@initAddKeyButton, @addNewMessageButton], (button) ->
        return button.isPresent()
      .then (buttons) ->
        return buttons[0].click()
