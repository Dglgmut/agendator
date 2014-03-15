require 'spec_helper'

describe User do
  describe "name" do
    it { should validate_presence_of :name }
  end

  describe "email" do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email) }
  end

  describe "password" do
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password}
  end
end
