# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'

  resources :recipes
  resources :foods
end
