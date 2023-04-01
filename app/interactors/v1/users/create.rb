module V1

	module Users

		class Create

			include Interactor

			def call
				
				user = User.new(params)
				
				if user.save
					context.result = user
					
				else
					context.fail!(error: user.errors)
				end
				
			end

			private

			delegate :params, to: :context

			def welcome_email

				# interactor = WelcomeEmail.call(user: user)

				# return if interactor.success!

				# context.fail(error: interactor.error)

			end

		end

	end

end