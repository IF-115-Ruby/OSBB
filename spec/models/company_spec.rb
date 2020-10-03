require 'rails_helper'

RSpec.describe Company, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:name).is_at_most(50) }
    it { should validate_length_of(:email).is_at_most(50) }
  end
end
