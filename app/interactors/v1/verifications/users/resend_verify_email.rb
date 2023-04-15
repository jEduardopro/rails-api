module V1
	module Verifications
		module Users
			class ResendVerifyEmail
				include Interactor

				def call
					# binding.pry
					# binding.pry
					# return if !user.present? || user.email_confirmation.present?
					return unless user.present? && user.email_confirmation.blank?

					user.tokens.destroy_all
					UserMailer.send_email_confirmation(user: user).deliver_later
				end

				private 

				delegate :params, to: :context

				attr_accessor :user

				def fail_context!(message)
					context.fail!(error: message)
				end

				def user
					@user ||= User.find_by(email: params[:email])
				end
			end
		end
	end
end