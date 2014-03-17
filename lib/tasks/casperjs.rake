namespace :casperjs do
  desc "TODO"
  task test: :environment do
    User.find_by_email('casperjs@test.com').destroy
    system("casperjs test casper/first_time_user_test.coffee")
    system("casperjs test casper/authenticate_then_make_and_cancel_a_reservation.coffee")
  end

end
