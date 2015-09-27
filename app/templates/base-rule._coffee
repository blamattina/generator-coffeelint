class <%= ruleClass %>
  rule:
    name: '<%= ruleUnderscored %>'
    level: 'error'
    message: '<%= ruleMessage %>'
    description: '<%= ruleDescription %>'

module.exports = <%= ruleClass %>
