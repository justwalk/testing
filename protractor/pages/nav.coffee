'use strict'

Page = require('astrolabe').Page

module.exports = Page.create
  adminCenter:
    get: -> element @by.cssContainingText '.nav-title.hidden-sm.ng-scope', '管理中心'
