path = require 'path'
assert = require 'yeoman-assert'
helpers = require('yeoman-generator').test
os = require 'os'
describe 'project files', ->
  beforeEach (done) ->
    helpers.run(path.join(__dirname, '../app'))
      .withOptions(skipInstall: true)
      .withPrompts(pkgName: 'no_bad_code')
      .withPrompts(ruleMessage: 'No bad code!')
      .withPrompts(ruleDescription: 'Description of my rule.')
      .on 'end', done

  it 'exist', ->
    assert.file [
      '.editorconfig'
      '.gitignore'
      'coffeelint.json'
      'jasmine-runner.js'
      'spec/support/jasmine.json'
    ]
