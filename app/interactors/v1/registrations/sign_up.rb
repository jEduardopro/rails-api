module V1
	module Registrations
		class SignUp
			include Interactor

			def call
				user = User.find_by(email: params[:email])
				if user.blank?
					context.fail!(error: 'User not found.')
				end
				return context.result = user if user.update(params)
				context.fail!(error: user.errors)
			end
			
			private
			delegate :params, :to :context
		end
	end
end