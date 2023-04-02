require 'sidekiq/web'

Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
	mount Sidekiq::Web => "/sidekiq"

	# resources :users

	resources :users, only: %i[] do 
		# collection do
		# 	post 'register', action: :create
		# end
	end

	post 'auth/register', action: :create, controller: :users
	post 'auth/verify', action: :verify_user_email, controller: :verifications

end
