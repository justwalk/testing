'use strict'

qrcodePage = require '../pages/qrcode.coffee'

describe 'delete QR code page testing', ->
  beforeEach ->
    qrcodePage.go()

  it 'should delete QR code ', ->
    qrcodePage.sumQr.count()
    .then (count)->
      qrcodePage.deleteQrCode()
      expect(qrcodePage.sumQr.count()).toBe count - 1
