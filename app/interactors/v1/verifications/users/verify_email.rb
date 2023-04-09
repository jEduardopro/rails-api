module V1
	module Verifications
		module Users
			class VerifyEmail
				include Interactor
				PASSWORD_RESET_SECRET = Rails.application.credentials.password_reset_secret
				VERIFIER = ActiveSupport::MessageVerifier.new(PASSWORD_RESET_SECRET)

				before do
					valid?
				end

				def call
					token_verified = VERIFIER.verified(params[:token], purpose: :login)
					if token_verified.nil?
						fail_context!('The token has been expired.')
					end
					# rescue ActiveSupport::MessageVerifier::InvalidSignature	

					return context.result = user if user.update(email_confirmation: DateTime.now)
					fail_context!(user.errors.full_messages)
				end

				private 

				delegate :params, to: :context

				attr_accessor :user

				def valid?
					@user = User.find_by(email: params[:email])

					if user.blank?
						fail_context!('User not found.')
					end

					if user.email_confirmation.presence
						fail_context!('The user is already verified.')
					end
				end

				def fail_context!(message)
					context.fail!(error: message)
				end
			end
		end
	end
end