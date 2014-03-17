casper.test.begin "Agendator redirects me to sign_up page on first time, and I must be able to sign up", 3, suite = (test) ->
  casper.start "http://localhost:3000/", ->
    test.assertExists "form[action=\"/users\"]", "signup form is found"
    @fill "form[action=\"/users\"]",
      "user[name]": "casperjs"
      "user[email]": "casperjs@test.com"
      "user[password]": "12341234"
      "user[password_confirmation]": "12341234"
    , true
    return

  casper.then ->
    test.assertTitle "Agendator", "title is ok"
    casper.waitForUrl /localhost:3000\/$/, ->
      test.assertExists "table.table.table-boarded.table-hover", "table exists"

  casper.run ->
    test.done()
    return

  return

