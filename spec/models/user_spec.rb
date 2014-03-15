require 'spec_helper'

describe User do
  let(:user) {FactoryGirl.create(:user)}

  describe "name" do
    it { should validate_presence_of :name }
    it { should allow_value("Teste", "teste").for(:name)}
    it { should_not allow_value("%este", "t3st3").for(:name)}
  end

  describe "email" do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email) }
  end

  describe "password" do
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password}
  end

  describe ".first_name" do
    it "is the first word from a name" do
      expect(user.first_name).to eq "test"
    end
  end

  describe ".reservations" do
    it {should have_many :reservations}
  end

end
