fs = require 'fs'
path = require 'path'
assert = require 'yeoman-assert'
helpers = require('yeoman-generator').test

describe 'generated package.json', ->
  beforeEach (done) ->
    helpers.run(path.join(__dirname, '../app'))
      .withOptions(skipInstall: true)
      .withPrompts(pkgName: 'no_bad_code')
      .withPrompts(ruleMessage: 'No bad code!')
      .withPrompts(ruleDescription: 'Description of my rule.')
      .on 'end', done

    @pkg = JSON.parse fs.readFileSync('package.json', 'utf8')

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

  it 'is configured to run jasmine', ->
    expect(@pkg.scripts.jasmine).toEqual 'node jasmine-runner.js'

    devDependencies = Object.keys @pkg.devDependencies
    expect(devDependencies).toContain 'jasmine'
    expect(devDependencies).toContain 'jasmine-spec-reporter'

  it 'has a test script' , ->
    expect(@pkg.scripts.test).toEqual 'npm run lint && npm run jasmine'
