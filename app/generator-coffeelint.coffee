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
      extractedName = extractRuleName _s.slugify(@appname)

      prompts = [
        {
          type: 'input'
          name: 'pkgName'
          message: 'What is the name of your coffeelint rule?'
          default: extractedName
        },
        {
          type: 'confirm'
          name: 'askForPkgNameAgain'
          message: 'The name above already exists on npm, choose another?'
          default: true
          when: (answers) ->
            done = @async()
            pkgName = "coffeelint-#{_s.slugify answers.pkgName}"

            npmName pkgName, (err, available) ->
              if not available
                done true
              else
                done false
        },
        {
          type: 'input'
          name: 'ruleDescription'
          message: 'Describe your rule?'
          default: _s.humanize extractedName
        },
        {
          type: 'input'
          name: 'ruleMessage'
          message: 'What message do you want to display when your rule fails?'
          default: _s.humanize extractedName
        }
      ]

      done = @async()
      @prompt prompts, (props) =>
        if props.askForPkgNameAgain
          return @prompting.askForRuleName.call this

        @pkgName = _s.slugify props.pkgName
        @ruleClass = _s.classify props.pkgName
        @ruleUnderscored = _s.underscored props.pkgName
        @ruleMessage = _s.humanize props.ruleMessage
        @ruleDescription = props.ruleDescription
        @appname = "coffeelint-#{@pkgName}"
        done()

  writing:
    app: ->
      @template '_README.md', 'README.md'
      @template '_package.json', 'package.json'
      @template 'index.js', 'index.js'
      @template 'base-rule._coffee', "src/#{@pkgName}.coffee"
      @template 'base-rule-spec._coffee', "spec/#{@pkgName}-spec.coffee"

    projectfiles: ->
      @copy 'editorconfig', '.editorconfig'
      @copy 'gitignore', '.gitignore'
      @copy 'coffeelint.json', 'coffeelint.json'
      @copy 'jasmine-runner.js', 'jasmine-runner.js'
      @copy 'jasmine.json', 'spec/support/jasmine.json'

  install: ->
    @installDependencies()
