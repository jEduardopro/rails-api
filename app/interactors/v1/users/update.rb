module V1
	module Users
		class Update
		include Interactor

		def call
			user = User.find_by(id: id)

			if user.blank?
				context.fail!(error: 'User not found')
			end

			return context.result = user if user.update(params)

			context.fail!(error: user.errors)
		end
		

		private
		delegate :params, :id, to: :context

		end
	end
end