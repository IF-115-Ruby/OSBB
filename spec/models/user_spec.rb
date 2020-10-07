require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.build(:user, last_name: "Doe", first_name: "John") }

  context "when valid Factory" do
    it "has a valid factory" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:osbb).optional }
  end

  describe "#full_name" do
    it "returns full name" do
      expect(user.full_name).to eq("John Doe")
    end
  end

  describe "#downcase_email" do
    it "downcases an email before saving" do
      user.email = "EXAMPLE@gmail.com"
      user.save
      expect(user.email).to eq("example@gmail.com")
    end

    it "downcases email before saving" do
      user.email = "example@gmail.com"
      user.save
      expect(user.email).to eq("example@gmail.com")
    end
  end

  describe "length is invalid" do
    it "does not allow a first name longer than 50 characters" do
      user.first_name = "a" * 51
      expect(user).not_to be_valid
    end

    it "does not allow a last name longer than 50 characters" do
      user.last_name = "a" * 51
      expect(user).not_to be_valid
    end

    it "does not allow a email longer than 50 characters" do
      user.email = "a" * 256
      expect(user).not_to be_valid
    end
  end

  describe "length is valid" do
    it "allow a first name no longer than 50 characters" do
      user.first_name = "a" * 49
      expect(user).to be_valid
    end

    it "allow a last name no longer than 50 characters" do
      user.last_name = "a" * 49
      expect(user).to be_valid
    end

    it "allow a email no longer than 254 characters" do
      user.email = "#{('a' * 245)}@gmail.com"
      expect(user).to be_valid
    end
  end

  describe "validations" do
    context 'when mobile is valid' do
      it 'be valid' do
        user.mobile = '0123456789'
        expect(user).to be_valid
      end

      it 'reject mobile that has more 10 digits' do
        user.mobile = '012345678991'
        expect(user).to be_valid
      end
    end

    context 'when mobile not valid' do
      it 'reject mobile that has characters' do
        user.mobile = '06866666ab'
        expect(user).not_to be_valid
      end

      it 'reject mobile that has less 10 digits' do
        user.mobile = '012345678'
        expect(user).not_to be_valid
      end
    end

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
#  id                     :bigint           not null, primary key
#  avatar                 :string
#  birthday               :date
#  email                  :string(254)      not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string(50)       not null
#  last_name              :string(50)       not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  mobile                 :string
#  role                   :integer
#  sex                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  osbb_id                :bigint

# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_osbb_id  (osbb_id)

# Foreign Keys
#
#  fk_rails_...  (osbb_id => osbbs.id)
#
