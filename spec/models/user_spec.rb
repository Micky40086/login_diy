require "rails_helper"

RSpec.describe User, type: :model do
  describe "email valid format" do
    it "submit correct format" do
      user = User.new(
        email: "mickey@gmail.com",
        password: "00000000",
        name: "Mickey",
      )
      expect(user).to be_valid
    end

    it "submit incorrect format" do
      user = User.new(
        email: "mickey####",
        password: "00000000",
        name: "Mickey",
      )
      expect(user).to be_invalid
    end
  end

  describe "email valid unique" do
    it "can't create same email User" do
      user = User.create(
        email: "mickey@gmail.com",
        password: "00000000",
        name: "Mickey",
      )

      user2 = User.new(
        email: "mickey@gmail.com",
        password: "00000000",
        name: "Mickey",
      )
      expect(user2).to be_invalid
    end
  end

  describe "password valid length" do
    it "email length < 8" do
      user = User.create(
        email: "mickey@gmail.com",
        password: "000000",
        name: "Mickey",
      )
      expect(user).to be_invalid
    end

    it "email length >= 8" do
      user = User.create(
        email: "mickey@gmail.com",
        password: "00000000",
        name: "Mickey",
      )
      expect(user).to be_valid
    end
  end
end
