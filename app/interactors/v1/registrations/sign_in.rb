module V1
	module Registrations
		class SignIn
			include Interactor

			def call
				@user = User.find_by(email: params[:email])
				if user.blank?
					context.fail!(error: 'User not found.')
				end

				if !user.email_confirmed?
					context.fail!(error: 'User is not verified')
				end

				if params[:password].blank?
					context.fail!(error: 'Password is not present')
				end

				if user.authenticate(params[:password])
					context.token = generate_auth_token
					context.user = user
				else 
					context.fail!(error: 'Invalid credentials')
				end
			end
			
			private
			delegate :params, :auth_token, to: :context
			attr_reader :user

			def generate_auth_token
				interactor = GenerateAuthToken.call(user: user)

				context.fail!(error: interactor.error) unless interactor.success?

				auth_token.call(interactor.result)

				interactor.result
			end
		end
	end
end