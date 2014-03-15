class Reservation < ActiveRecord::Base
  include Schedulable, Cancelable

  belongs_to :user
  validates :user, :presence => true
end
