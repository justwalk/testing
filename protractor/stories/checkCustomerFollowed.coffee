'use strict'

customerPage = require '../pages/customers.coffee'
args = require '../../args.coffee'

describe 'check customers if followed official Account', ->
  beforeEach ->
    customerPage.go()

  it 'shoud exist customer name', ->
    browser.waitForAngular()
    expect(customerPage.customerName.getText()).toEqual args.protractor.checkCustomerFollow.name
