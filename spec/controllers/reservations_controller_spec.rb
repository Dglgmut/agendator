require 'spec_helper'

describe ReservationsController do
  context "logged user" do
    before { login_user }
    let(:response_json) { JSON.parse(response.body) }

    describe "GET 'index'" do
      before {FactoryGirl.create(:reservation, user: User.last)}
      before { get 'index' }
      it { should respond_with 200 }
      it "must return a json with the next reservations" do
        expect(response_json[0]["id"]).to eq Reservation.last.id
        expect(response_json[0]["name"]).to eq Reservation.last.user.name
      end
    end

    describe "POST 'create'" do
      context "with valid parameters" do
        let(:parameters) {{scheduled_at: 1.day.from_now}}
        before { post 'create', parameters }

        it { should respond_with 200 }
        it "must create a reservation" do
          expect(Reservation.count).to eq 1
          expect(response_json["id"]).to eq Reservation.last.id
        end
      end

      context "with duplicated scheduled_at parameter" do
        before {FactoryGirl.create(:reservation)}
        let!(:parameters) {{scheduled_at: Reservation.last.scheduled_at}}
        before { post 'create', parameters }

        it { should respond_with 403 }
        it "must return a error message" do
          expect(response_json["error_messages"]).to eq({"scheduled_at" => ["has already been taken"] })
        end
      end
    end

    describe "POST 'cancel'" do
      let(:reservation) {FactoryGirl.create(:reservation)}
      let(:parameters) {{id: reservation.id}}
      context "canceling a cancelable reservation" do
        before { post 'cancel', parameters }

        it { should respond_with 200 }
        it "must set canceled as true" do
          expect(reservation.reload.canceled).to be_true
          expect(response_json["id"]).to eq reservation.id
        end
      end
    end
  end
end
