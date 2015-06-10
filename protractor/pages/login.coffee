'use strict'

Page = require('astrolabe').Page

module.exports = Page.create
  url:
    value: '/site/login'

  usernameInput:
    get: -> @find.by.id 'email'

  passwordInput:
    get: -> @find.by.id 'password'

  loginButton: 　
    get: -> element @by.buttonText 'Sign In'

  login:
    value: (username, password) ->
      @usernameInput.sendKeys username
      @passwordInput.sendKeys password
      @loginButton.click()
