FactoryBot.define do
  factory :news do
    title { Faker::TvShows::Buffy.character }
    short_description { Faker::TvShows::Buffy.quote }
    long_description { Faker::Lorem.paragraph_by_chars }
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
