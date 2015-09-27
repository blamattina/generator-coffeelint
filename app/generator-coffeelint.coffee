yeoman = require 'yeoman-generator'
chalk = require 'chalk'
yosay = require 'yosay'
npmName = require 'npm-name'
_ = require 'lodash'
_s = require 'underscore.string'

extractRuleName = require './extract-rule-name'

module.exports = yeoman.generators.Base.extend
  prompting:
    askFor: ->
      # Have Yeoman greet the user.
      @log yosay "Welcome to the dandy #{chalk.red('Coffeelint')} generator!"

    askForRuleName: ->
      defaultRuleName = extractRuleName @appname

      prompts = [
        {
          type: 'input'
          name: 'ruleName'
          message: 'What is the name of your coffelint rule?'
          default: defaultRuleName
        },
        {
          type: 'confirm'
          name: 'askForRuleNameAgain'
          message: 'The name above already exists on npm, choose another?'
          default: true
          when: (answers) ->
            done = @async()
            name = "coffeelint-#{answers.ruleName}"

            npmName name, (err, available) ->
              if not available
                done true
              else
                done false
        }
      ]

      done = @async()
      @prompt prompts, (props) =>
        if props.askForRuleNameAgain
          return @prompting.askForRuleName.call this

        @ruleName = props.ruleName
        @ruleClassName = _s.classify @ruleName
        @ruleUnderscored = _s.underscored @ruleName
        @ruleHumanized = _s.humanize @ruleName
        @appname = _s.slugify "coffeelint-#{@ruleName}"
        done()

  writing:
    app: ->
      @template '_package.json', 'package.json'
      @template 'index.js', 'index.js'
      @template 'base-rule._coffee', "src/#{@ruleName}.coffee"

    projectfiles: ->
      @copy 'editorconfig', '.editorconfig'
      @copy 'coffeelint.json', 'coffeelint.json'
      @copy 'jasmine.json', 'spec/support/jasmine.json'

  install: ->
    @installDependencies()
