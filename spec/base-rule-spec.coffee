path = require 'path'
assert = require 'yeoman-assert'
helpers = require('yeoman-generator').test

describe 'generated base-rule.coffee', ->
  beforeEach (done) ->
    helpers.run(path.join(__dirname, '../app'))
      .withOptions(skipInstall: true)
      .withPrompts(ruleName: 'no_bad_code')
      .on 'end', done

    @generatedFile = 'src/no_bad_code.coffee'

  it 'exists', ->
    assert.file [@generatedFile]

  it 'defines and exports the class', ->
    assert.fileContent @generatedFile, 'class NoBadCode'

    assert.fileContent @generatedFile, 'module.exports = NoBadCode'

  it 'defines the rule name', ->
    assert.fileContent @generatedFile, 'name: \'no_bad_code\''

  it 'defines the rule message', ->
    assert.fileContent @generatedFile, 'message: \'No bad code\''

