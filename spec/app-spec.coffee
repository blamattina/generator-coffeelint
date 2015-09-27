path = require('path')
assert = require('yeoman-assert')
helpers = require('yeoman-generator').test
os = require('os')
describe 'coffeelint:app', ->
  beforeEach (done) ->
    helpers.run(path.join(__dirname, '../app'))
      .withOptions(skipInstall: true)
      .withPrompts(ruleName: 'no_bad_code')
      .on 'end', done

  it 'creates files', ->
    assert.file [
      'package.json'
      '.editorconfig'
    ]

  describe 'package.json', ->

    it 'sets the package name', ->
      assert.JSONFileContent 'package.json', name: 'coffeelint-no-bad-code'

    it 'contains coffeelintrule keyword', ->
      # https://github.com/clutchski/coffeelint/blob/master/3rd_party_rules.md
      assert.JSONFileContent 'package.json', keywords: ['coffeelintrule']
