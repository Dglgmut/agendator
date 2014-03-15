class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :presence => true
  validates :name, :format => { :with => /\A([A-Z]|[a-z]|\s)+\Z/ }

  def first_name
    name[/\A\w+/]
  end
end
