module Cancelable
  extend ActiveSupport::Concern

  included do
    validates :canceled, :inclusion => { :in => [true, false] }

    default_scope { where(canceled: false) }
    scope :canceled, -> { where(canceled: true) }
  end

  def cancel
    update_attribute :canceled, true
  end

end
