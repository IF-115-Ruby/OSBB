require 'raven/base'
require 'raven/integrations/rails'

Raven.configure do |config|
  config.dsn = ENV['SENTRY_DSN']
end
