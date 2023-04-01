class UsersController < ApplicationController


	def index 

	end

	def create
		
		interactor = V1::Users::Create.call(params: create_params)

		if interactor.success?
			render json: {user: interactor.result}, status: :ok
		else
			render json: {error: interactor.error}, status: :bad_request
		end

	end

	private 
	
	def create_params
		params.permit(:name, :email)
	end

end
