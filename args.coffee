'use strict'

rondomString = (len) ->
  len = len or 3
  myString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  charLength = myString.length
  targetString = ""
  for i in [0..len]
    targetString += myString.charAt(Math.floor(Math.random() * charLength))
  targetString

module.exports =
  appium:
    customizeMenu:
      mainMenu: 'first'
      subMenu: 'second'

    followOfficialAccount:
      ID: 'omnisocials'
      name: '群脉SCRM'
      checkMessage: 'Hi,欢迎再次回到群脉SCRM微信平台!'

    qrCode:
      checkMessage: 'QR-code'

    receiveMessage:
      checkMessage: 'testAbstract'

    sendMessageToServer:
      content: 'testing'
      checkMessage: 'Hi,群脉SCRM微信平台，有什么可以帮助你的？'

    userInputKeyWord:
      keyWord: 'catalog'
      checkMessage: 'catalog message'

  protractor:
    checkCustomerFollow:
      name: 'aaron wangu'

    sendMessageToUsers:
      content: 'send message to users testing'
      type: 'Part' # All means send message to all, Part means send message to specify

    interactionWithUser:
      index: 0          # index means which item you have choosed
      sendMessage: 'interaction with single user testing'
      receiveMessage: 'user send message to official account'

    autoreply:
      ruleName: 'query catalog'
      key: 'catalog'
      replayMessage: 'catalog message'

    customMenu:
      menuName: 'first'
      subMenuName: 'second'
      message: 'click menu and reply message'
      outSiteUrl: 'https://dev.quncrm.com'

    qrcode:
      name: 'qrcode'
      content: 'QR-code'

    graphicsContent:
      articleTitle: 'testTitle'
      imageFileUrl: '../resource/a.jpg'
      description: 'testAbstract'
      mainText: 'testing article mainText input'
      sourceUrl: 'https://dev.quncrm.com'

    addCustomerTag:
      tagName: rondomString(3)
