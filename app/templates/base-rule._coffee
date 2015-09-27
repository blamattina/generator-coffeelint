class <%= ruleClass %>
  rule:
    name: '<%= ruleUnderscored %>'
    level: 'error'
    message: '<%= ruleMessage %>'
    description: '<%= ruleDescription %>'

  lintLine: ->
    false

module.exports = <%= ruleClass %>
