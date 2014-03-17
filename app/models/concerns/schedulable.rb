module Schedulable
  extend ActiveSupport::Concern

  included do
    default_scope { where("scheduled_at >= ? AND scheduled_at <= ?",
                     Time.now.beginning_of_day,
                     Time.now + 6.days) }

    validates :scheduled_at, :presence => true
    validate :scheduled_at_cannot_be_in_the_past,
      :scheduled_at_must_have_limited_hours,
      :scheduled_at_cannot_be_at_same_hour_of_day

  end

  private
    def other_schedule_at_same_time?
        Reservation.where("date_trunc('hour', scheduled_at) = ? AND id <> ?",
                          scheduled_at.strftime('%F %H:00:00'), id || -1).any?
    end

    def scheduled_at_cannot_be_at_same_hour_of_day
      errors.add(:scheduled_at, "has already been taken") if
        scheduled_at.present? && other_schedule_at_same_time?
    end

    def scheduled_at_cannot_be_in_the_past
      errors.add(:scheduled_at, "can't be in the past") if
        scheduled_at.present? && scheduled_at < Time.now
    end

    def scheduled_at_must_have_limited_hours
      errors.add(:scheduled_at, "must be between 6:00 AM and 11:00 PM") if
        scheduled_at.present? && scheduled_at.hour < 6
    end

end
