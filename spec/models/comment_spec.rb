require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:news) { FactoryBot.build(:news) }
  let!(:comment) { FactoryBot.build(:comment, commentable: news, user: news.user) }

  context "when valid Factory" do
    it "has a valid factory" do
      expect(comment).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:commentable) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }

    context 'with db column' do
      it { is_expected.to have_db_column(:commentable_id).of_type(:integer) }
      it { is_expected.to have_db_column(:commentable_type).of_type(:string) }
    end
  end
end

# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint
#  user_id          :bigint
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_user_id                              (user_id)
#
