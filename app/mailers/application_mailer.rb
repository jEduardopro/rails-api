class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

	PASSWORD_RESET_SECRET = Rails.application.credentials.password_reset_secret
  VERIFIER = ActiveSupport::MessageVerifier.new(PASSWORD_RESET_SECRET)
end
