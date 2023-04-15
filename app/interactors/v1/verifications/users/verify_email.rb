module V1
	module Verifications
		module Users
			class VerifyEmail
				include Interactor
				TOKEN_EXPIRATION_TIME = 90.seconds

				before do
					valid?
				end

				def call					
					@user_token = user.tokens.find_by(token: params[:token])

					if user_token.blank?
						fail_context!('The token is invalid.')
					end

					if token_expired?
						fail_context!('The token is already expired.')
					end

					ActiveRecord::Base.transaction do 
						user.update!(email_confirmation: DateTime.now)
						user_token.destroy!
					end

					context.result = user

				rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotDestroyed => e					
					fail_context!(e.message)
				end

				private 

				delegate :params, to: :context

				attr_accessor :user, :user_token

				def valid?
					
					if params[:email].blank?
						fail_context!('Email is required.')
					end

					if params[:token].blank?
						fail_context!('Token is required.')
					end
					
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

				def token_expired?
					user_token.created_at + TOKEN_EXPIRATION_TIME < Time.zone.now
				end
				
			end
		end
	end
end