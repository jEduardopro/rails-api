require 'sidekiq/web'

Rails.application.routes.draw do
  get 'registrations/sign_up'
  get 'registrations/sign_in'

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

	scope :auth do 
		post 'register', action: :sign_up, controller: :registrations
		post 'verify', action: :verify_user_email, controller: :verifications
	end

end
