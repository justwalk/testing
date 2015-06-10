'use strict'

module.exports = (grunt) ->
  grunt.initConfig
    protractor:
      options:
        configFile: './protractor/conf.coffee'
        keepAlive: true
        noColor: false
        verbose: true

      checkCustomerIfExist:
        options:
          args:
            specs: ['protractor/stories/checkCustomerFollowed.coffee']

      addCustomerTag:
        options:
          args:
            specs: ['protractor/stories/addCustomerTag.coffee']

      addGraphics:
        options:
          args:
            specs: ['protractor/stories/graphics.coffee']

      sendMessageToUsers:
        options:
          args:
            specs: ['protractor/stories/sendMessageToUsers.coffee']

      autoReply:
        options:
          args:
            specs: ['protractor/stories/autoReply.coffee']

      customMenu:
        options:
          args:
            specs: ['protractor/stories/customMenu.coffee']

      addQrCode:
        options:
          args:
            specs: ['protractor/stories/qrCode.coffee']

      deleteGraphics:
        options:
          args:
            specs: ['protractor/stories/deleteGraphics.coffee']

      deleteMenu:
        options:
          args:
            specs: ['protractor/stories/deleteMenu.coffee']

      deleteQrCode:
        options:
          args:
            specs: ['protractor/stories/deleteQrCode.coffee']

      deleteAutoReplyMessage:
        options:
          args:
            specs: ['protractor/stories/deleteAutoReplyMessage.coffee']

    mochaTest:
      options:
          reporter: 'spec'
          require: 'coffee-script/register'
          quiet: false

      followOfficalAccount:
        src: ['appium/stories/followOfficialAccount.coffee']

      receiveMessage:
        src: ['appium/stories/receiveMessage.coffee']

      userInputKeyWord:
        src: ['appium/stories/userInputKeyWord.coffee']

      customizeMenu:
        src: ['appium/stories/customizeMenu.coffee']

      qrCodeScan:
        src: ['appium/stories/qrCode.coffee']

      unfollowOfficalAccount:
        src: ['appium/stories/unFollowOfficialAccount.coffee']

      quitSession:
        src: ['appium/stories/quitSession.coffee']

      sendMessageToOfficialAccount:
        src: ['appium/stories/sendMessageToServer.coffee']

  grunt.loadNpmTasks 'grunt-protractor-runner'
  grunt.loadNpmTasks 'grunt-mocha-test'

  # Refer to:
  #   node_modules/appium/bin/appium.js
  #   node_modules/appium/lib/server/main.js
  #   node_modules/appium/lib/server/parser.js
  #   node_modules/appium/lib/server/logger.js
  grunt.registerTask 'appiumServer', 'Start a appium server with default settings', ->
    done = @async()

    argsParser = require 'appium/lib/server/parser.js'
    logFactory = require 'appium/lib/server/logger.js'

    args = argsParser().parseKnownArgs()[0]
    # So appium's console log won't mess our test reports
    args.loglevel = 'error'
    logFactory.init args

    appium = require 'appium'
    appium.run args, ->
      grunt.log.ok 'Appium server started'
      # appium changed current working directory, we need to change it back
      process.chdir __dirname
      done()
    , ->
      grunt.log.error 'Appium server stopped'
