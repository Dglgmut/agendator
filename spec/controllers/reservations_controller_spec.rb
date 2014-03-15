require 'spec_helper'

describe ReservationsController do
  context "logged user" do
    before { login_user }

    describe "GET 'index'" do
      before { get 'index' }
      it { should respond_with 200 }
    end

    describe "POST 'create'" do
      before { post 'create' }
    end

    describe "POST 'cancel'" do
      before { post 'cancel' }
    end
  end
end
