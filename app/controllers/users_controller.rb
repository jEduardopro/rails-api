class UsersController < ApplicationController


	def index 

	end

	def create
		
		user = User.new(create_params)

		if user.save
			render json: {user: user}, status: :ok
		else
			render json: {error: user.errors.full_messages}, status: :bad_request
		end

	end

	private 
	
	def create_params
		params.permit(:name, :email)
	end

end
