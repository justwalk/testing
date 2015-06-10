'use strict'

Page = require('astrolabe').Page

module.exports = Page.create
  url:
    value: '/customer/follower'

  customerOperationButton:
    get: -> element.all(@by.css('.operate-icon.tag-icon')).get 0

  customerOperationTagAddTab:
    # get: -> element.all(@by.css('.btn-add-radius.btn.col-md-3')).get 1
    get: -> @find.by.css '.btn-add-radius.btn.col-md-3'


  customerOperationTagInput:
    # get: -> element.all(@by.css('.form-control.tag-name-text')).get 1
    get: -> $ '.form-control.tag-name-text '

  customerOperationSaveButton:
    get: -> element.all(@by.css('.btn-success.btn-operate-tag')).get 0

  customerOperationCheckbox:
    get: -> element.all(@by.css('.col-md-4.ng-scope')).all(@by.css('.wm-checkbox')).last()

  customerOperationSubmitButton:
    get: -> element.all(@by.css('.btn-success.btn-operate-tag')).get 1

  sumCustomersTag:
    get: -> @find.by.css '.follower-span'

  customerName:
    get: -> element.all(@by.css('.ng-binding.ng-scope.tooltipstered')).get 1

  addCustomerTag:
    value: (tagName)->
      @customerOperationButton.click()
      @customerOperationTagAddTab.click()
      @customerOperationTagInput.sendKeys tagName
      @customerOperationSaveButton.click()
      @customerOperationCheckbox.click()
      @customerOperationSubmitButton.click()
