Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, only: [:index, :show, :new, :create]
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
