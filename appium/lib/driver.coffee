'use strict'

wd = require 'wd'
chai = require 'chai'
chaiAsPromised = require 'chai-as-promised'
chai.use chaiAsPromised
chai.should()

chaiAsPromised.transferPromiseness = wd.transferPromiseness
driver = wd.promiseChainRemote
  host: 'localhost'
  port: 4723

desired =
  newCommandTimeout: 1000
  platformName: 'Android'
  deviceName: '4d0082b95408a09b'
  appPackage: 'com.tencent.mm'
  appActivity: 'com.tencent.mm.ui.LauncherUI'


module.exports =
  driver.init desired,
  @driver = driver
