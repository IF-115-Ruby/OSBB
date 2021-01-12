source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'any_login'
gem 'axlsx'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap4-kaminari-views'
gem 'carrierwave', '~> 2.0'
gem 'caxlsx_rails'
gem 'ckeditor'
gem 'country_select', '~> 4.0'
gem 'devise'
gem 'dotenv-rails', groups: %i[development test]
gem 'elasticsearch'
gem 'factory_bot_rails'
gem 'faker'
gem 'faraday_middleware-aws-sigv4'
gem 'fog-aws'
gem 'font_awesome5_rails', '~> 1.2.0'
gem 'geocoder'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'meta-tags', '~> 2.13.0'
gem 'mini_magick'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'premailer-rails'
gem 'pretender', '~> 0.3.4'
gem 'puma', '~> 4.1'
gem 'pundit'
gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
gem 'rails-i18n'
gem 'ransack'
gem 'react-rails', '~> 2.6.1'
gem 'roo'
gem 'roo-xls'
gem 'routing-filter'
gem 'rubocop', '~> 0.89.1'
gem 'rubocop-rails', '~> 2.8.1'
gem 'rubyzip'
gem 'sass-rails', '>= 6'
gem 'searchkick'
gem 'sentry-raven'
gem 'sidekiq'
gem 'sidekiq-cron', '~> 1.1'
gem 'simple_form', '~> 5.0', '>= 5.0.3'
gem 'sinatra', '>= 1.3.0', require: nil
gem 'slim-rails', '~> 3.2.0'
gem 'strong_migrations'
gem 'telegram-bot'
gem 'turbolinks', '~> 5'
gem 'webpacker'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

group :development, :test do
  gem 'amazing_print'
  gem 'annotate'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 4.0.1'
  gem 'rubocop-rspec', '~> 1.43', '>= 1.43.2', require: false
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'pry', '~> 0.13.1'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '~> 3.33'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'rspec-sidekiq'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 4.4', '>= 4.4.1'
  gem 'simplecov', '= 0.17', require: false
  gem 'webdrivers'
end

group :production do
  gem 'wkhtmltopdf-heroku'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
