class Comment < ApplicationRecord
  include ActionView::Helpers::DateHelper

  default_scope { order(created_at: :desc, commentable_type: :asc) }

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, presence: true

  paginates_per 5

  def time_ago
    "#{distance_of_time_in_words(Time.current, updated_at)} ago"
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
