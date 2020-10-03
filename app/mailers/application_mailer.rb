class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILER_ADDRESS']
  layout 'mailer'
end
