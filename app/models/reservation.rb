class Reservation < ActiveRecord::Base
  include Schedulable, Cancelable

  belongs_to :user
  validates :user, :presence => true

  scope :with_user_name, -> { select("reservations.id, scheduled_at, name").joins(:user) }
end
