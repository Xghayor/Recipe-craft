Rails.application.routes.draw do
  devise_for :users

  resources :users do
  end

  # Defines the root path route ("/") to the public_recipes controller's index action
  root "users#index"

  get '/public_recipes', to: 'public_recipes#index'
end
