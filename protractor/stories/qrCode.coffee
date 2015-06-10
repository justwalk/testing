'use strict'

qrcodePage = require '../pages/qrcode.coffee'
args = require '../../args.coffee'

describe 'QR code page testing', ->
  beforeEach ->
    qrcodePage.go()

  it 'should add QR code ', ->
    qrcodePage.sumQr.count()
    .then (count)->
      qrcodePage.goToAddQrCode()
      qrcodePage.qrCodeNameInput.sendKeys args.protractor.qrcode.name
      qrcodePage.qrcodeContentTextArea.sendKeys args.protractor.qrcode.content
      qrcodePage.submitButton.click()
      expect(qrcodePage.sumQr.count()).toBe count + 1
