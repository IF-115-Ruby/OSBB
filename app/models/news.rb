class News < ApplicationRecord
  belongs_to :user
  belongs_to :osbb

  validates :long_description, :short_description, :title, presence: true
  validate :image_size_validation

  scope :visible, -> { where(is_visible: true) }
  scope :ordered, -> { order('created_at DESC') }

  mount_uploader :image, ImageUploader
  paginates_per 5

  private

  def image_size_validation
    errors[:image] << "Should be less than 2MB" if image.size > 2.megabytes
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
