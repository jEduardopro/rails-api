class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_email_confirmation.subject
  #
  def send_email_confirmation(user:)		
		@user = user
		@token = VERIFIER.generate(user.email, expires_in: 30.seconds, purpose: :login)
		@front_end_url = "http://localhost:9000?email=#{user.email}&token=#{@token}"
    mail(
			to: user.email,
			from: 'rails-account@support.com',
			subject: 'Email Confirmation'
		)
  end
end
