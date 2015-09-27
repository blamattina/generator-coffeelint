'use strict'
yeoman = require('yeoman-generator')
chalk = require('chalk')
yosay = require('yosay')

module.exports = yeoman.generators.Base.extend

  prompting: ->
    done = @async()
    # Have Yeoman greet the user.
    @log yosay('Welcome to the dandy ' + chalk.red('Coffeelint') + ' generator!')
    prompts = [ {
      type: 'confirm'
      name: 'someOption'
      message: 'Would you like to enable this option?'
      default: true
    } ]
    @prompt prompts, ((props) ->
      @props = props
      # To access props later use this.props.someOption;
      done()
    ).bind(this)

  writing:
    app: ->
      @fs.copy @templatePath('_package.json'), @destinationPath('package.json')
      @fs.copy @templatePath('_bower.json'), @destinationPath('bower.json')

    projectfiles: ->
      @fs.copy @templatePath('editorconfig'), @destinationPath('.editorconfig')
      @fs.copy @templatePath('jshintrc'), @destinationPath('.jshintrc')

  install: ->
    @installDependencies()
