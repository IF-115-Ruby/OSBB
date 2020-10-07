FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    avatar { Faker::File.file_name }
    password { Faker::Internet.password }
    mobile { Faker::Number.leading_zero_number(digits: 10) }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    sex { Faker::Demographic.sex }
    role { Faker::Number.between(from: 0, to: 3) }
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
