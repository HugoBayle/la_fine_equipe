require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'Validation Profile' do

    it "should validate phone number length" do
      user = User.create(email: "test@test.fr", password: "azerty")
      profile = Profile.new(name: "Sam", phone_number: "123", bio: "Je ne suis qu'un test", user_id: user.id)
      expect(profile.valid?).to be false
    end

    it "should validate presence of phone number" do
      user = User.create(email: "test@test.fr", password: "azerty")
      profile = Profile.new(name: "Sam", bio: "Je ne suis qu'un test", user_id: user.id)
      expect(profile.valid?).to be false
    end

    it "should validate presence of name" do
      user = User.create(email: "test@test.fr", password: "azerty")
      profile = Profile.new(phone_number: "1234567890", bio: "Je ne suis qu'un test", user_id: user.id)
      expect(profile.valid?).to be false
    end

    it "should validate presence of bio" do
      user = User.create(email: "test@test.fr", password: "azerty")
      profile = Profile.new(name: "Sam", phone_number: "1234567890", user_id: user.id)
      expect(profile.valid?).to be false
    end

    it "should be a valid profile" do
      user = User.create(email: "test@test.fr", password: "azerty")
      profile = Profile.new(name: "Sam", phone_number: "1234567890", bio: "Je ne suis qu'un test", user_id: user.id)
      expect(profile.valid?).to be true
    end

  end
end
