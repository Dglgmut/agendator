class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :redirect_to_sign_up_on_first_access

  protected
    def redirect_to_sign_up_on_first_access
      redirect_to new_user_registration_url if first_time
    end

    def first_time
      unless cookies[:first_time]
        return cookies[:first_time] = true
      end
    end
end
