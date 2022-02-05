Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "sessions#index"

  devise_for :users

  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

  resources :sessions, except: :destroy
  resources :shipments #, only: [:new, :show] # should be this; but rails 7 be busted hard core
end
