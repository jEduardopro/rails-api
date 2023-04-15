class RegistrationsController < ApplicationController
  def sign_up
		interactor = V1::Registrations::SignUp.call(params: sign_up_params)
		if interactor.success?
			head(:ok)
		else
			render json: {error: interactor.error}, status: :bad_request
		end
  end

  def sign_in
		interactor = V1::Registrations::SignIn.call(params: sign_in_params, auth_token: set_auth_token)
		
		if interactor.success?
			render json: {user: interactor.user, token: interactor.token}, status: :ok
		else
			render json: {error: interactor.error}, status: :bad_request
		end
  end
	
	private

	def sign_up_params
		params.permit(:email, :password, :password_confirmation)
	end

	def sign_in_params
		params.permit(:email, :password)
	end

	def set_auth_token
		->(token) {response.set_header('Token', token)}
	end
	
	
end
