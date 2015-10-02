path = require 'path'
assert = require 'yeoman-assert'
helpers = require('yeoman-generator').test

describe 'generated README.md', ->
  beforeEach (done) ->
    helpers.run(path.join(__dirname, '../app'))
      .withOptions(skipInstall: true)
      .withPrompts(pkgName: 'no bad code')
      .withPrompts(ruleMessage: 'No bad code!')
      .withPrompts(ruleDescription: 'Description of rule.')
      .on 'end', done

    @generatedFile = 'README.md'

  it 'describes the module', ->
    assert.fileContent @generatedFile, '# coffeelint-no-bad-code'

    assert.fileContent @generatedFile, '> Description of rule.'

  it 'has installation instructions', ->
    assert.fileContent @generatedFile, 'npm install -D coffeelint-no-bad-code'

  it 'has configuration instructions', ->
    assert.fileContent @generatedFile, '"no_bad_code": {'
    assert.fileContent @generatedFile, '"module": "coffeelint-no-bad-code",'
