require 'spec_helper'


describe Reservation do
  before { Timecop.freeze(DEFAULT_TIME_FOR_RESERVATION) }
  let(:reservation) {FactoryGirl.create(:reservation)}

  describe ".user" do
    it {should belong_to :user}
    it {should validate_presence_of :user}
  end

  describe "scheduled_at" do
    let(:reservation_from_one_hour_ago) {FactoryGirl.build(:reservation, scheduled_at: 1.hour.ago)}
    let(:reservation_before_6_am) {FactoryGirl.build(:reservation, scheduled_at: Time.zone.parse("05:30") + 1.day)}

    it {should validate_presence_of :scheduled_at}

    it "must be unique" do
      expect(FactoryGirl.build(:reservation, scheduled_at: reservation)).to have(1).errors_on(:scheduled_at)
    end

    it "must be set after `timenow` on create" do
      expect(reservation_from_one_hour_ago).to have(1).errors_on(:scheduled_at)
      expect(reservation).to have(0).errors_on(:scheduled_at)
    end

    it "must be set between 6am and 11pm" do
      expect(reservation_before_6_am).to have(1).errors_on(:scheduled_at)
    end

    it 'must select reservations from next week' do
      FactoryGirl.create(:reservation, canceled: true) #0
      FactoryGirl.create(:reservation, scheduled_at: 7.days.from_now) #0
      FactoryGirl.build(:reservation, scheduled_at: 2.hours.ago).save(validate: false) #1
      FactoryGirl.create(:reservation, scheduled_at: 6.days.from_now) #2
      expect(Reservation.count).to eq 2
    end
  end

  describe "canceled" do
    it "must be cancelable" do
      expect(reservation.cancel).to be_true
      expect(Reservation.count).to eq 0
      expect(Reservation.canceled.count).to eq 1
    end
  end

  describe ".to_hash_with_user_name" do
    it "must show the reservation name, id and scheduled_at with proper format" do
      user = reservation.user
      expect(Reservation.hash_with_user_name).to eq([{name: user.first_name,
                                                      id: reservation.id,
                                                      scheduled_at: reservation.scheduled_at.strftime("%F %H:00")
                                                   }])
    end
  end
end
