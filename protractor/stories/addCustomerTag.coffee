'use strict'

customerPage = require '../pages/customers.coffee'
args = require '../../args.coffee'

describe 'add customer tag page testing', ->
  beforeEach ->
    customerPage.go()

  it 'should add tag of the customer', ->
    customerPage.addCustomerTag(args.protractor.addCustomerTag.tagName)
    customerPage.customerOperationButton.click()
    expect(customerPage.customerOperationCheckbox.isEnabled()).toBeTruthy()
