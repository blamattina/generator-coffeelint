path = require 'path'
assert = require 'yeoman-assert'
helpers = require('yeoman-generator').test
os = require 'os'
describe 'coffeelint:app', ->
  beforeEach (done) ->
    helpers.run(path.join(__dirname, '../app'))
      .withOptions(skipInstall: true)
      .withPrompts(pkgName: 'no_bad_code')
      .withPrompts(ruleMessage: 'No bad code!')
      .withPrompts(ruleDescription: 'Description of my rule.')
      .on 'end', done

  it 'creates files', ->
    assert.file [
      '.editorconfig'
      'coffeelint.json'
      'spec/support/jasmine.json'
    ]
