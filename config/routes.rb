Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
  resources :records, only: [:create, :destroy] 
  resources :talks, only: %i(create)
  # config/routes.rb
  namespace :api do
    namespace :v1 do
      # another api routes
      get '/me' => "credentials#me"
    end
  end
end
