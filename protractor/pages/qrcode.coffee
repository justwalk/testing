'use strict'

Page = require('astrolabe').Page
protractor = require 'protractor'

module.exports = Page.create
  url:
    value: '/channel/qrcode/555eda88e4b0b09dd54f46a1'

  initAddQrCodeButton:
    get: -> element @by.css '.menber-create-icon.center-block.cp'

  addQrCodeButton:
    get: -> element @by.css '.btn.btn-success.broadcast-new-btn.pull-right.ng-binding.ng-scope'

  qrCodeNameInput:
    get: -> @find.by.model 'qrcode.detail.name'

  qrcodeContentTextArea:
    get: -> element.all(@by.css('.message.message-text.form-control.ng-pristine.ng-valid')).get 1

  submitButton:
    get: -> element @by.css '.btn.btn-success.mr20.user-btn'

  cancelButton:
    get: -> element @by.css '.btn.btn-default.user-btn.ng-binding'

  sumQr:
    get: -> element.all(@by.repeater('item in table.data track by $index'))

  deleteQrCodeButton:
    get: -> element.all(@by.css('.operate-icon.delete-icon')).get 0

  deleteQrCodeSubmitButton:
    get: -> @find.by.css '.btn-success.btn-operate-tag'

  deleteQrCode:
    value: ->
      @deleteQrCodeButton.click()
      @deleteQrCodeSubmitButton.click()

  goToAddQrCode:
    value: ->
      protractor.promise.filter [@initAddQrCodeButton, @addQrCodeButton], (button) ->
        button.isPresent()
      .then (buttons) ->
        buttons[0].click()
