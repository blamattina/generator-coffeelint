module.exports = (appname) ->
  regEx = /^coffeelint-(.+)/

  if regEx.test appname
    match = regEx.exec appname
    match[1]
  else
    appname
