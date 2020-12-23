FactoryBot.define do
  factory :post do
    title { Faker::Movies::Hobbit.character }
    short_description { Faker::Movies::Hobbit.quote }
    long_description { Faker::Lorem.sentence(word_count: 230) }
    is_visible { true }
    is_private { false }
    user
    osbb

    trait :with_image do
      image { File.open("#{Rails.root}/app/assets/images/if-mailer.png") }
    end
  end
end

# == Schema Information
#
# Table name: posts
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
#  index_posts_on_is_visible  (is_visible)
#  index_posts_on_osbb_id     (osbb_id)
#  index_posts_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (osbb_id => osbbs.id)
#  fk_rails_...  (user_id => users.id)
#
