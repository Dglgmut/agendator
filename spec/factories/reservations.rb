# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservation do
    scheduled_at "2014-03-15 09:19:25"
    canceled false
    user nil
  end
end
