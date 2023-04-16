class AuthenticatedController < ApplicationController

	include ActionController::HttpAuthentication::Token::ControllerMethods
	include InteractorRenderHelper

	include JwtAuth
	attr_reader :user

	# hook of all controllers
	append_before_action :after_authenticating

	def after_authenticating
		render json: {message: 'Unauthorize'}, status: 401 if user.blank?
	end
end