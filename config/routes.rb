# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'

  resources :users
  resources :recipes
  resources :foods
end
