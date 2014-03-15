# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservation do
    scheduled_at 1.hour.from_now
    canceled false
    user
  end
end
