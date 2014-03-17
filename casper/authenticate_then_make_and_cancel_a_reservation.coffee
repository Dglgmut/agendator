fs = require('fs')
data = fs.read('casper_cookies.txt')
phantom.cookies = JSON.parse(data)
casper.test.begin "Sign In and then create an reservation", 4, suite = (test) ->
  casper.start "http://localhost:3000/users/sign_in", ->
    test.assertExists "form[action=\"/users/sign_in\"]", "signin form is found"
    @fill "form[action=\"/users/sign_in\"]",
      "user[email]": "casperjs@test.com"
      "user[password]": "12341234"
    , true
    return

  casper.then ->
    test.assertTitle "Agendator", "title is ok"
    casper.waitForUrl /localhost:3000\/$/, ->
      test.assertExists "table.table.table-boarded.table-hover", "table exists, signed in successfully"
      test.assertExists 'td:last-child[data-datetimerecord$="20:00"]', "clickable element exists"

  casper.thenClick 'td:last-child[data-datetimerecord$="20:00"]'


  casper.run ->
    test.done()
    return

  return

