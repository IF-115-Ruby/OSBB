source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'any_login'
gem 'axlsx'
gem 'carrierwave', '~> 2.0'
gem 'caxlsx_rails'
gem 'ckeditor'
gem 'country_select', '~> 4.0'
gem 'dotenv-rails', groups: %i[development test]
gem 'geocoder'
gem 'mini_magick'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
gem 'pretender', '~> 0.3.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'rubocop', '~> 0.89.1'
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'devise'
gem 'font_awesome5_rails', '~> 1.2.0'
gem 'jbuilder', '~> 2.7'
gem 'meta-tags', '~> 2.13.0'
gem 'ransack'
gem 'rubocop-rails', '~> 2.8.1'
gem 'sentry-raven'
gem 'sidekiq'
gem 'sidekiq-cron', '~> 1.1'
gem 'simple_form', '~> 5.0', '>= 5.0.3'
gem 'sinatra', '>= 1.3.0', require: nil
gem 'slim-rails', '~> 3.2.0'
# Use Active Storage variant
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap4-kaminari-views'
gem 'factory_bot_rails'
gem 'faker'
gem 'fog-aws'
gem 'kaminari'
gem 'premailer-rails'
gem 'pundit'
gem 'rails-i18n'
gem 'roo'
gem 'roo-xls'
gem 'routing-filter'
gem 'rubyzip'
gem 'strong_migrations'
gem 'telegram-bot'
# Gem 'Wicked_pdf' & 'wkhtmltopdf-binary' for export pdf
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'wkhtmltopdf-heroku'

group :development, :test do
  gem 'amazing_print'
  gem 'annotate'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 4.0.1'
  gem 'rubocop-rspec', '~> 1.43', '>= 1.43.2', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.2'
  gem 'pry', '~> 0.13.1'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 3.33'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'rspec-sidekiq'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 4.4', '>= 4.4.1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'simplecov', '= 0.17', require: false
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
