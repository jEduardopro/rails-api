class VerificationsController < ApplicationController

	def verify_user_email
		interactor = V1::Verifications::Users::VerifyEmail.call(params: verify_user_email_params)

		if interactor.success?
			render json: {user: interactor.result}, status: :ok
		else
			render json: {error: interactor.error}, status: :bad_request
		end
	end

	def resend_verify_user_email
		V1::Verifications::Users::ResendVerifyEmail.call(params: resend_verify_user_email_params)
		head(:ok)
	end
	

	private

	def verify_user_email_params
		params.permit(:email, :token)
	end

	def resend_verify_user_email_params
		params.permit(:email)
	end
end
