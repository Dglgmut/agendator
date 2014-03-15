# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "test#{n}@test.com" }
    password "12345678"
    name "test tes te"
  end
end
