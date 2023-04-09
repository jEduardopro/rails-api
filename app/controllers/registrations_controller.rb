class RegistrationsController < ApplicationController
  def sign_up
		interactor = V1::Registrations::SignUp.call(params: sign_up_params)
		if interactor.success?
			render json: {user: interactor.result}, status: :ok
		else
			render json: {error: interactor.error}, status: :ok
		end
  end

  def sign_in
		interactor = V1::Registrations::SignIn.call(sign_in_params)

  end

	private

	def sign_up_params
		params.permit(:email, :password, :password_confirmation)
	end

	def sign_in_params
		params.permit(:email, :password)
	end
	
end
