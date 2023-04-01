module V1
	module Users
		class Create
			include Interactor

			after do 
				send_email_confirmation
			end

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

			def send_email_confirmation
				UserMailer.send_email_confirmation(user: context.result).deliver_later
			end
		end
	end
end