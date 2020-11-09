require_relative 'boot'

require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OSBB
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.generators do |g|
      g.template_engine :slim
      g.test_framework :rspec, fixtures: true, views: false
      g.fixture_replacement :factory_bot_rails, dir: 'spec/factories'
    end

    # For getting layout with style file for devise notifications
    config.to_prepare do
      Devise::Mailer.layout 'mailer'
    end

    config.assets.initialize_on_precompile = false
    config.assets.precompile += %w[mailer.css]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
