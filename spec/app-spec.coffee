path = require 'path'
assert = require 'yeoman-assert'
helpers = require('yeoman-generator').test
os = require 'os'
describe 'coffeelint:app', ->
  beforeEach (done) ->
    helpers.run(path.join(__dirname, '../app'))
      .withOptions(skipInstall: true)
      .withPrompts(ruleName: 'no_bad_code')
      .on 'end', done

  it 'creates files', ->
    assert.file [
      '.editorconfig'
      'coffeelint.json'
      'src/no_bad_code.coffee'
      'spec/support/jasmine.json'
    ]
