'use strict'

Page = require('astrolabe').Page

module.exports = Page.create
  channelManage:
    get: -> element @by.cssContainingText '.nav-title.hidden-sm.hidden-xs.ng-scope', '渠道管理'
