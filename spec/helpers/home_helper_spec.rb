require 'spec_helper'

describe HomeHelper do
  describe ".next_days" do
    it "should show the next six days and today" do
      next_days do |x|
        expect(x).to match(/^\d{2}\-\d{2}\-\d{4}$/)
      end
    end
  end

  describe ".hours_range" do
    it "should show the hours available for the day" do
      hours_range do |hour|
        expect(hour).to match(/\d{2}\:\d{2}/)
      end
    end
  end
end
