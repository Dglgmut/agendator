class Reservation < ActiveRecord::Base
  include Schedulable, Cancelable

  belongs_to :user
  validates :user, :presence => true

  scope :with_user_name, -> { select("id, scheduled_at, user_id").includes(:user) }

  def Reservation.hash_with_user_name
    Reservation.with_user_name.map do |reservation|
      {
        id: reservation.id,
        name: reservation.user.first_name,
        scheduled_at: reservation.scheduled_at.strftime("%d-%m-%Y %H:00")
      }
    end
  end
end
