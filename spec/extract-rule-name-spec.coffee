extractRuleName = require 'app/extract-rule-name'

describe 'extract-rule', ->
  it 'removes the coffeelint- prefix from the appname', ->
    rule = extractRuleName 'coffeelint-my-rule'
    expect(rule).toBe 'my-rule'

  it 'returns the app name if no prefix can be removed', ->
    rule = extractRuleName 'coffeelnt-my-rule'
    expect(rule).toBe 'coffeelnt-my-rule'
