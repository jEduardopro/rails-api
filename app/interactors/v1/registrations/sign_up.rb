module V1
	module Registrations
		class SignUp
			include Interactor

			def call				
				user = User.find_by(email: params[:email])
				if user.blank?
					context.fail!(error: 'User not found.')
				end

				if !user.email_confirmed?
					context.fail!(error: 'User is not verified')
				end

				if params[:password].blank?
					context.fail!(error: 'Password is not present')
				end

				if params[:password_confirmation].blank?
					context.fail!(error: 'Password confirmation is not present')
				end


				return context.result = user if user.update(params)
				context.fail!(error: user.errors)
			end
			
			private
			delegate :params, to: :context

		end
	end
end