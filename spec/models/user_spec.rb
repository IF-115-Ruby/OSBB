require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.build(:user, last_name: "Doe", first_name: "John") }

  context "when valid Factory" do
    it "has a valid factory" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  describe "#full_name" do
    it "returns full name" do
      expect(user.full_name).to eq("John Doe")
    end
  end

  describe "validations" do
    context "when email is valid" do
      it "user is valid" do
        user.email = "example@gmail.com"
        expect(user).to be_valid
      end
    end

    context "when email is invalid" do
      it "user is valid" do
        user.email = "invali-email.com"
        expect(user).not_to be_valid
      end
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
