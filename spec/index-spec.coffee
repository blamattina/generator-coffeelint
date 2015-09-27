path = require 'path'
assert = require 'yeoman-assert'
helpers = require('yeoman-generator').test

describe 'generated index.js', ->
  beforeEach (done) ->
    helpers.run(path.join(__dirname, '../app'))
      .withOptions(skipInstall: true)
      .withPrompts(pkgName: 'no_bad_code')
      .withPrompts(ruleMessage: 'No bad code!')
      .withPrompts(ruleDescription: 'Description of my rule.')
      .on 'end', done

  it 'exists', ->
    assert.file ['index.js']

  it 'requires coffeescript', ->
    assert.fileContent 'index.js', '''require('coffee-script/register');'''

  it 'exports the coffeelint rule', ->
    assert.fileContent 'index.js',
      '''module.exports = require('./src/no-bad-code');'''
