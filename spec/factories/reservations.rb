# Read about factories at https://github.com/thoughtbot/factory_girl

DEFAULT_TIME_FOR_RESERVATION = Time.zone.parse("#{1.day.from_now.strftime('%F')} 12:00")

FactoryGirl.define do
  factory :reservation do
    scheduled_at DEFAULT_TIME_FOR_RESERVATION
    canceled false
    user
  end
end
