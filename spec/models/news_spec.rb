require 'rails_helper'

RSpec.describe News, type: :model do
  let!(:news) { FactoryBot.build(:news) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:short_description) }
    it { is_expected.to validate_presence_of(:long_description) }

    describe 'image' do
      it 'reject image that has more than 1.5 mb' do
        file = File.open(File.join(Rails.root, 'spec/support/images/image-3mb.jpg'))
        news.image = file
        allow(news.image).to receive(:size).and_return(4.megabytes)
        news.valid?
        expect(news.errors[:image]).to include("Should be less than 2MB")
      end
    end

    context 'when image is not correct format' do
      file = File.open(File.join(Rails.root, 'spec/support/images/image-3mb.txt'))
      it { is_expected.not_to allow_value(file).for(:image) }
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:osbb) }
    it { is_expected.to belong_to(:user) }
  end
end

# == Schema Information
#
# Table name: news
#
#  id                :bigint           not null, primary key
#  image             :string
#  is_private        :boolean
#  is_visible        :boolean
#  long_description  :text
#  short_description :string
#  title             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  osbb_id           :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_news_on_osbb_id  (osbb_id)
#  index_news_on_user_id  (user_id)
#
