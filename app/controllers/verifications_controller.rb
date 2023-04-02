class VerificationsController < ApplicationController

	def verify_user_email
		interactor = V1::Verifications::Users::VerifyEmail.call(params: verify_user_email_params)

		if interactor.success?
			render json: {user: interactor.result}, status: :ok
		else
			render json: {error: interactor.error}, status: :bad_request
		end
	end

	private

	def verify_user_email_params
		params.permit(:email, :token)
	end
end
