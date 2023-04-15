require 'sidekiq/web'

Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
	mount Sidekiq::Web => "/sidekiq"

	# resources :users

	resources :users, only: %i[create] do 
		# collection do
		# 	post 'register', action: :create
		# end
	end

	scope :api do
		resources :pages, only: %i[index]
		post 'sign_out', action: :sign_out, controller: :sessions
	end

	scope :auth do 
		post 'register', action: :sign_up, controller: :registrations
		post 'sign_in', action: :sign_in, controller: :registrations
		post 'verify', action: :verify_user_email, controller: :verifications
		post 'resend_verify_email', action: :resend_verify_user_email, controller: :verifications
	end

end
