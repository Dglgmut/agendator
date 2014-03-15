class Reservation < ActiveRecord::Base
  belongs_to :user

  validates :scheduled_at, :uniqueness => true
  validates :scheduled_at, :presence => true
  validate :scheduled_at_cannot_be_in_the_past,
    :scheduled_at_must_have_limited_hours

  private

    def scheduled_at_cannot_be_in_the_past
      errors.add(:scheduled_at, "can't be in the past") if
        scheduled_at.present? && scheduled_at < Time.now
    end

    def scheduled_at_must_have_limited_hours
      errors.add(:scheduled_at, "must be between 6:00 AM and 11:00 PM") if
        scheduled_at.present? && scheduled_at.hour <= 6
    end
end
