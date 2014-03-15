class Reservation < ActiveRecord::Base
  include Schedulable

  belongs_to :user
  validates :user, :presence => true

  validates :canceled, :inclusion => { :in => [true, false] }

  default_scope { where(canceled: false) }
  scope :canceled, -> { where(canceled: true) }

  def cancel
    update_attribute :canceled, true
  end
end
