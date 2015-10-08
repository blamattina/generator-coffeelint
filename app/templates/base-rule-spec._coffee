<%= ruleClass %> = require '../'

coffeelint = require 'coffeelint'
coffeelint.registerRule <%= ruleClass %>

describe '<%= ruleClass %>', ->

  describe 'smoke test', ->
    beforeEach ->
      lintyCode = '''
        # Anything will fail
      '''
      config =
        <%= ruleUnderscored %>: {}

      @errors = coffeelint.lint(lintyCode, config)

    it 'has an warning on line 1', ->
      expect(@errors.length).toBe 1
      error = @errors[0]
      expect(error.level).toBe 'warn'
      expect(error.lineNumber).toBe 1
      expect(error.rule).toBe '<%= ruleUnderscored %>'
