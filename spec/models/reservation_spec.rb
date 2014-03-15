require 'spec_helper'

describe Reservation do
  let(:reservation) {FactoryGirl.create(:reservation)}
  describe ".user" do
    it {should belong_to :user}
  end

  describe "scheduled_at" do
    let(:reservation_from_one_hour_ago) {FactoryGirl.build(:reservation, scheduled_at: 1.hour.ago)}
    let(:reservation_before_6_am) {FactoryGirl.build(:reservation, scheduled_at: Time.zone.parse("05:30") + 1.day)}

    it {should validate_presence_of :scheduled_at}
    it {should validate_uniqueness_of :scheduled_at}

    it "must be set after `timenow` on create" do
      expect(reservation_from_one_hour_ago).to have(1).errors_on(:scheduled_at)
      expect(reservation).to have(0).errors_on(:scheduled_at)
    end

    it "must be set between 6am and 11pm" do
      expect(reservation_before_6_am).to have(1).errors_on(:scheduled_at)
    end
  end
end
