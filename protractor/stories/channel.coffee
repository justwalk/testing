'use strict'

navPage = require '../pages/nav.coffee'
sidebarPage = require '../pages/sidebar.coffee'
channelPage = require '../pages/channel.coffee'
userPage = require '../pages/user.coffee'

describe 'channel page testing', ->
  beforeEach ->
    channelPage.go()

  it 'should jump to user page or channel page', ->
    navPage.adminCenter.click()
    expect(channelPage.currentUrl).toEqual browser.baseUrl + userPage.url
    sidebarPage.channelManage.click()
    expect(channelPage.currentUrl).toEqual browser.baseUrl + channelPage.url

  it 'should jump to weibo authorizing page ', ->
    channelPage.clickAddWeiboButton()

    isAngularSite false
    browser.sleep 3000
    expect(browser.getTitle()).toEqual '应用授权 - 群脉SCRM_Dev'
    isAngularSite true

  it 'should jump to weixin authorizing page', ->
    channelPage.clickAddWeixinButton()

    isAngularSite false
    browser.sleep 3000
    expect(browser.getTitle()).toEqual '微信公众平台'
    isAngularSite true
