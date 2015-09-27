fs = require 'fs'
path = require 'path'
assert = require 'yeoman-assert'
helpers = require('yeoman-generator').test

describe 'generated package.json', ->
  beforeEach (done) ->
    helpers.run(path.join(__dirname, '../app'))
      .withOptions(skipInstall: true)
      .withPrompts(ruleName: 'no_bad_code')
      .on 'end', done

    @pkg = JSON.parse fs.readFileSync('package.json', 'utf8')

  it 'exists', ->
    assert.file ['package.json']

  it 'sets the package name', ->
    expect(@pkg.name).toBe 'coffeelint-no-bad-code'

  it 'contains coffeelintrule keyword', ->
    # https://github.com/clutchski/coffeelint/blob/master/3rd_party_rules.md
    expect(@pkg.keywords).toContain 'coffeelintrule'

  it 'is configured to lint', ->
    expect(@pkg.scripts.lint).toEqual 'coffeelint src/ spec/'

    devDependencies = Object.keys @pkg.devDependencies
    expect(devDependencies).toContain 'coffeelint'
    expect(devDependencies).toContain 'coffeelint-no-focused-jasmine-specs'
