Rails.application.routes.draw do
  devise_for :users

  resources :users

  resources :recipes do
    resources :recipe_foods
  end

  resources :foods

  resources :shopping_lists, only: [:index]

  # Defines the root path route ("/") to the public_recipes controller's index action
  root "users#index"

  get '/public_recipes', to: 'public_recipes#index'
  delete '/recipes/:id', to: 'recipes#destroy', as: 'destroy_recipe'
  delete '/foods/:id', to: 'foods#destroy', as: 'destroy_food'
end
