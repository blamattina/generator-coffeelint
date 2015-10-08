class <%= ruleClass %>
  rule:
    name: '<%= ruleUnderscored %>'
    level: 'warn'
    message: '<%= ruleMessage %>'
    description: '<%= ruleDescription %>'

  lintLine: ->
    true

module.exports = <%= ruleClass %>
