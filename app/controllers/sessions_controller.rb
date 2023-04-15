class SessionsController < AuthenticatedController

	def sign_out
		bearer_token = request.headers['Authorization']
		token = bearer_token.gsub('Bearer', '').strip
		
		AuthToken.create(token: token)

		head :ok
	end
end