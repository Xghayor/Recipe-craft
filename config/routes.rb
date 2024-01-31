Rails.application.routes.draw do
  devise_for :users

  resources :users do
  end

  resources :recipes do
  end

  # Defines the root path route ("/") to the public_recipes controller's index action
  root "users#index"

  get '/public_recipes', to: 'public_recipes#index'
  delete '/recipes/:id', to: 'recipes#destroy', as: 'destroy_recipe'
end
