module V1
	module Registrations
		class GenerateAuthToken
			include Interactor
			TOKEN_EXPIRATION_SECONDS = 84000

			def call
				if user.blank?
					context.fail!(error: 'User not found.')
				end

				context.result = JWT.encode(payload, signing_key)

			end
			private
			delegate :user, to: :context

			def payload
				{sub: user.id, iat: expiration, exp: expiration, data: token_data}
			end

			def expiration
				Time.now.to_i+TOKEN_EXPIRATION_SECONDS
			end

			def token_data
				{id: user.id}
			end
			
			def signing_key
				"7dc97b5b916eaa5df43a5ef87596d884cc77e9d3c400c4cb6131f2429026bae7"
			end
		end
	end
end