# The base mailer class for the application.
# Provides common functionality for sending emails.
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
