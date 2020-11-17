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
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w[ckeditor/*]
    config.autoload_paths += %W[#{config.root}/app/models/ckeditor]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Settings for the pool of renderers:
    config.react.server_renderer_pool_size  ||= 1  # ExecJS doesn't allow more than one on MRI
    config.react.server_renderer_timeout    ||= 20 # seconds
    config.react.server_renderer = React::ServerRendering::BundleRenderer
    config.react.server_renderer_options = {
      files: ["server_rendering.js"], # files to load for prerendering
      replay_console: true # if true, console.* will be replayed client-side
    }
    # Changing files matching these dirs/exts will cause the server renderer to reload:
    config.react.server_renderer_extensions = %w[jsx js]
    config.react.server_renderer_directories = ["/app/javascript/"]
  end
end
