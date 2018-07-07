Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users, only: [:show]
  use_doorkeeper
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :records, only: [:create, :destroy] 
  
  # config/routes.rb
  namespace :api do
    namespace :v1 do
      # another api routes
      get '/me' => "credentials#me"
      resources :talks, only: %i(create)
    end
  end
  
  #mount Alexa::Engine, at: "/alexa"
end