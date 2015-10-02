class <%= ruleClass %>
  rule:
    name: '<%= ruleUnderscored %>'
    level: 'error'
    message: '<%= ruleMessage %>'
    description: '<%= ruleDescription %>'

  lintLine: ->
    true

module.exports = <%= ruleClass %>
