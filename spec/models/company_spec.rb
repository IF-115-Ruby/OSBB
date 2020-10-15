require 'rails_helper'

RSpec.describe Company, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_length_of(:email).is_at_most(50) }
  end

  describe 'associations' do
    context 'when have_one' do
      it 'account' do is_expected.to have_one(:account) end
      it 'address' do is_expected.to have_one(:address) end
    end
  end
end

# == Schema Information
#
# Table name: companies
#
#  id           :bigint           not null, primary key
#  company_type :string
#  email        :string
#  fax          :integer
#  name         :string
#  phone        :string(14)
#  website      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_companies_on_name  (name)
#
