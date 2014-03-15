class Reservation < ActiveRecord::Base
  include Schedulable

  belongs_to :user
end
