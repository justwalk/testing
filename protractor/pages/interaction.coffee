'use strict'

Page = require('astrolabe').Page

module.exports = Page.create
  url:
    value: '/channel/interaction/555eda88e4b0b09dd54f46a1'

  AllMessageTabUrl:
    value: '/channel/interaction/555eda88e4b0b09dd54f46a1?active=0'

  todayMessageTabUrl:
    value: '/channel/interaction/555eda88e4b0b09dd54f46a1?active=1'

  yesterdayMessageTabUrl:
    value: '/channel/interaction/555eda88e4b0b09dd54f46a1?active=2'

  beforeYesterdayMessageTabUrl:
    value: '/channel/interaction/555eda88e4b0b09dd54f46a1?active=3'

  earlierMessageTabUrl:
    value: '/channel/interaction/555eda88e4b0b09dd54f46a1?active=4'

  AllMessageTab:
    get: -> element @by.repeater('tab in tabs').row 0

  todayMessageTab:
    get: -> element @by.repeater('tab in tabs').row 1

  yesterdayMessageTab:
    get: -> element @by.repeater('tab in tabs').row 2

  beforeYesterdayMessageTab:
    get: -> element @by.repeater('tab in tabs').row 3

  earlierMessageTab:
    get: -> element @by.repeater('tab in tabs').row 4

  messageReplyIcon:
    get: -> element.all(@by.css('.col-md-1.interact-message-reply.cp'))

  userReplyContent:
    get: -> element.all(@by.css('.message-content.ng-binding.ng-scope')).get 0

  messageReplyTextarea:
    get: -> element.all(@by.css('.message.message-text.form-control.ng-pristine.ng-valid')).get 1

  messageReplyButton:
    get: -> @find.by.css '.btn.btn-success.ng-scope'

  interactionWithUser:
    value: (index, content) ->
      @messageReplyIcon.get(index).click()
      @messageReplyTextarea.sendKeys content
      @messageReplyButton.click()
