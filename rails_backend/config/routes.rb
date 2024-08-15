Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'

  # get '/user/:name', to: 'user#show', as: 'user_by_name'
  resources :user_stat
  resources :user
  resources :beat_boxer, only: [:show, :create, :destroy, :index]
  resources :match, only: [:show, :create, :update, :destroy, :index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
