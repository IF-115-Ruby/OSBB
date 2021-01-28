require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment) { FactoryBot.build(:comment) }

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

  describe '#time_ago' do
    it 'return correct time after creation' do
      comment.updated_at = Time.current + 1.day
      expect(comment.time_ago).to include('1 day ago')
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
