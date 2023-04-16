module JwtAuth
	extend ActiveSupport::Concern

	included do 
		before_action :validate_jwt_auth
	end

	def validate_jwt_auth
		authenticate_with_http_token do |token|		
			return false if AuthToken.find_by(token: token).present?

			payload = JWT.decode(*[token, '7dc97b5b916eaa5df43a5ef87596d884cc77e9d3c400c4cb6131f2429026bae7']).first
			data = payload['data']
			
			@user = User.find_by(id: data['id'])

			return false unless @user.present?
			true

		rescue JWT::VerificationError,
						JWT::DecodeError,
						JWT::ExpiredSignature,
						OpenSSL::PKey::RSAError
			false
		end
	end
end