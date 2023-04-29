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

	def update
		interactor = V1::Users::Update.call(params: update_params, id: params[:id])
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

	def update_params
		params.permit(:name, :cover_photo)
	end
end
