require 'spec_helper'

describe HomeController do
  before {request.cookies[:first_time] = true}
  describe "#index" do
    context "when I am not logged in" do
      before { get :index }

      it { should respond_with 302 }
      it { should redirect_to new_user_session_path }
    end

    context "when I am loggend in" do
      before { login_user }
      before { get :index }

      it { should respond_with 200 }
    end
  end
end
