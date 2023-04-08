module V1
	module Registrations
		class SignIn
			include Interactor

			def call
				
			end
			
			private
			delegate :params, :to :context
		end
	end
end