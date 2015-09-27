path = require 'path'
assert = require 'yeoman-assert'
helpers = require('yeoman-generator').test

describe 'generated base-rule.coffee', ->
  beforeEach (done) ->
    helpers.run(path.join(__dirname, '../app'))
      .withOptions(skipInstall: true)
      .withPrompts(pkgName: 'no bad code')
      .withPrompts(ruleMessage: 'No bad code!')
      .withPrompts(ruleDescription: 'Description of rule.')
      .on 'end', done

    @generatedFile = 'src/no-bad-code.coffee'

  it 'defines and exports the class', ->
    assert.fileContent @generatedFile, 'class NoBadCode'

    assert.fileContent @generatedFile, 'module.exports = NoBadCode'

  it 'defines the rule name', ->
    assert.fileContent @generatedFile, 'name: \'no_bad_code\''

  it 'defines the rule message', ->
    assert.fileContent @generatedFile, 'message: \'No bad code!\''

  it 'defines the rule description', ->
    assert.fileContent @generatedFile, 'description: \'Description of rule.\''
