class RegistrationsController < ApplicationController
  def sign_up
		interactor = V1::Registrations::SignUp.call(sign_up_params)

  end

  def sign_in
		interactor = V1::Registrations::SignIn.call(sign_in_params)

  end

	private

	def sign_up_params
		params.permit(:email, :password)
	end

	def sign_in_params
		params.permit(:email, :password)
	end
	
end
