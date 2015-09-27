fs = require 'fs'
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
      'package.json'
      '.editorconfig'
      'coffeelint.json'
      'index.js'
      'src/no_bad_code.coffee'
      'spec/support/jasmine.json'
    ]

  describe 'package.json', ->

    beforeEach ->
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
