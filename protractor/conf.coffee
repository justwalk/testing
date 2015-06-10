'use strict'

exports.config =
  capabilities:
    browserName: 'chrome'
    platform: "LINUX",

  specs: ['./stories/*']
  baseUrl: 'https://staging.quncrm.com'
  allScriptsTimeout: 11000
  getPageTimeout: 10000
  jasmineNodeOpts:
    onComplete: null,
    isVerbose: true,
    showColors: true,
    includeStackTrace: true,
    defaultTimeoutInterval: 360000

  onPrepare: ->
    # To show the right line numbers in stack trace
    require 'coffee-errors'

    global.isAngularSite = (flag) ->
      browser.ignoreSynchronization = !flag

    # To avoid responsive view on small screen cause 'element not visble' error
    browser.driver.manage().window().setSize(1360, 900)

    loginPage = require './pages/login.coffee'
    params = browser.params
    loginPage.go()
    loginPage.login params.login.username, params.login.password

  params:
    login:
      username: 'iqixing00005@163.com'
      password: 'abc123_'
